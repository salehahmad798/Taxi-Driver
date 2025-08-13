
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/features/driver/data/models/document_model.dart';
import 'package:taxi_driver/features/driver/data/models/review_models.dart';
import 'package:taxi_driver/features/driver/data/providers/api_provider.dart';
import 'dart:async';

import 'package:taxi_driver/routes/app_routes.dart';

class DocumentReviewController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  // ==================  Observable variables =================== 
  var documents = <ReviewItem>[].obs;
  var vehiclePhotos = <ReviewItem>[].obs;
  var overallStatus = ReviewStatus.underReview.obs;
  var isLoading = false.obs;
  var refreshing = false.obs;
  var autoRefreshEnabled = true.obs;

  // ====================== Progress tracking ================
  var totalItems = 0.obs;
  var approvedItems = 0.obs;
  var rejectedItems = 0.obs;
  var pendingItems = 0.obs;

  Timer? _refreshTimer;

  @override
  void onInit() {
    super.onInit();
    loadReviewData();
    startAutoRefresh();
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  Future<void> loadReviewData() async {
    try {
      isLoading.value = true;
      
      // ============== Load documents and photos in parallel ==================
      final results = await Future.wait([
        _apiProvider.getDocuments(),
        _apiProvider.getVehiclePhotos(),
      ]);

      final documentsResponse = results[0];
      final photosResponse = results[1];

      // ==================== Process documents =========================
      if (documentsResponse.isOk && documentsResponse.body != null) {
        final List<dynamic> documentsJson = documentsResponse.body['documents'] ?? [];
        documents.value = documentsJson.map((json) {
          final doc = DocumentModel.fromJson(json);
          return ReviewItem(
            id: doc.id ?? '',
            title: doc.type ?? '',
            type: ReviewItemType.document,
            status: _mapStatus(doc.status ?? 'pending'),
            uploadDate: doc.uploadDate,
            reviewDate: doc.reviewDate,
            reviewNotes: doc.reviewNotes,
            filePath: doc.filePath,
            serverUrl: json['url'],
            isRequired: doc.isRequired,
          );
        }).toList();
      }

      // =================== Process vehicle photos ==================
      if (photosResponse.isOk && photosResponse.body != null) {
        final List<dynamic> photosJson = photosResponse.body['photos'] ?? [];
        vehiclePhotos.value = photosJson.map((json) {
          return ReviewItem(
            id: json['id']?.toString() ?? '',
            title: json['type'] ?? '',
            type: ReviewItemType.vehiclePhoto,
            status: _mapStatus(json['status'] ?? 'pending'),
            uploadDate: json['upload_date'],
            reviewDate: json['review_date'],
            reviewNotes: json['review_notes'],
            filePath: json['file_path'],
            serverUrl: json['url'],
            isRequired: json['is_required'] ?? false,
          );
        }).toList();
      }

      _calculateProgress();
      _updateOverallStatus();

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load review data: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    } finally {
      isLoading.value = false;
    }
  }

  ReviewStatus _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return ReviewStatus.approved;
      case 'rejected':
        return ReviewStatus.rejected;
      case 'under_review':
      case 'reviewing':
        return ReviewStatus.underReview;
      default:
        return ReviewStatus.pending;
    }
  }

  void _calculateProgress() {
    final allItems = [...documents, ...vehiclePhotos];
    totalItems.value = allItems.length;
    approvedItems.value = allItems.where((item) => item.status == ReviewStatus.approved).length;
    rejectedItems.value = allItems.where((item) => item.status == ReviewStatus.rejected).length;
    pendingItems.value = allItems.where((item) => item.status == ReviewStatus.pending || item.status == ReviewStatus.underReview).length;
  }

  void _updateOverallStatus() {
    final allItems = [...documents, ...vehiclePhotos];
    final requiredItems = allItems.where((item) => item.isRequired).toList();

    if (requiredItems.isEmpty) {
      overallStatus.value = ReviewStatus.approved;
      return;
    }

    final approvedRequired = requiredItems.where((item) => item.status == ReviewStatus.approved).length;
    final rejectedRequired = requiredItems.where((item) => item.status == ReviewStatus.rejected).length;

    if (approvedRequired == requiredItems.length) {
      overallStatus.value = ReviewStatus.approved;
    } else if (rejectedRequired > 0) {
      overallStatus.value = ReviewStatus.rejected;
    } else if (requiredItems.any((item) => item.status == ReviewStatus.underReview)) {
      overallStatus.value = ReviewStatus.underReview;
    } else {
      overallStatus.value = ReviewStatus.pending;
    }
  }

  Future<void> refreshData() async {
    refreshing.value = true;
    await loadReviewData();
    refreshing.value = false;
  }

  void startAutoRefresh() {
    if (!autoRefreshEnabled.value) return;
    
    _refreshTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (!isLoading.value && autoRefreshEnabled.value) {
        refreshData();
      }
    });
  }

  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    autoRefreshEnabled.value = false;
  }

  void toggleAutoRefresh() {
    if (autoRefreshEnabled.value) {
      stopAutoRefresh();
    } else {
      autoRefreshEnabled.value = true;
      startAutoRefresh();
    }
  }

  Future<void> resubmitItem(ReviewItem item) async {
    try {
      final response = await _apiProvider.resubmitDocument(item.id);
      
      if (response.isOk) {
        //=================  Update item status ==================
        if (item.type == ReviewItemType.document) {
          final index = documents.indexWhere((doc) => doc.id == item.id);
          if (index != -1) {
            documents[index].status = ReviewStatus.pending;
            documents[index].reviewNotes = null;
            documents.refresh();
          }
        } else {
          final index = vehiclePhotos.indexWhere((photo) => photo.id == item.id);
          if (index != -1) {
            vehiclePhotos[index].status = ReviewStatus.pending;
            vehiclePhotos[index].reviewNotes = null;
            vehiclePhotos.refresh();
          }
        }

        _calculateProgress();
        _updateOverallStatus();

        Get.snackbar(
          'Success',
          'Item resubmitted for review',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to resubmit item',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    }
  }

  void proceedToNext() {
    // if (overallStatus.value == ReviewStatus.approved) {
    //   Get.toNamed('/availability');
    // } else if (overallStatus.value == ReviewStatus.rejected) {
    //   _showRejectionDialog();
    // } else {
    //   Get.snackbar(
    //     'Please Wait',
    //     'Documents are still under review. Please wait for approval.',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.orange[100],
    //     colorText: Colors.orange[800],
    //   );
    // }


      Get.toNamed(AppRoutes.availabilityMain);
  }

  void _showRejectionDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Documents Rejected'),
        content: Text('Some documents have been rejected. Please review the feedback and resubmit the required items.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _handleRejectedItems();
            },
            child: Text('Fix Issues'),
          ),
        ],
      ),
    );
  }

  void _handleRejectedItems() {
    final rejectedDocs = documents.where((doc) => doc.status == ReviewStatus.rejected).toList();
    final rejectedPhotos = vehiclePhotos.where((photo) => photo.status == ReviewStatus.rejected).toList();

    if (rejectedDocs.isNotEmpty) {
      Get.toNamed('/document-upload');
    } else if (rejectedPhotos.isNotEmpty) {
      Get.toNamed('/vehicle-details');
    }
  }

  String getStatusMessage() {
    switch (overallStatus.value) {
      case ReviewStatus.approved:
        return 'All documents approved! You can proceed to the next step.';
      case ReviewStatus.rejected:
        return 'Some documents were rejected. Please check the feedback and resubmit.';
      case ReviewStatus.underReview:
        return 'Your documents are currently under review. Please wait for approval.';
      default:
        return 'Documents submitted and waiting for review.';
    }
  }

  Color getStatusColor() {
    switch (overallStatus.value) {
      case ReviewStatus.approved:
        return Colors.green;
      case ReviewStatus.rejected:
        return Colors.red;
      case ReviewStatus.underReview:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  IconData getStatusIcon() {
    switch (overallStatus.value) {
      case ReviewStatus.approved:
        return Icons.check_circle;
      case ReviewStatus.rejected:
        return Icons.cancel;
      case ReviewStatus.underReview:
        return Icons.hourglass_empty;
      default:
        return Icons.pending;
    }
  }

  double get progressPercentage {
    if (totalItems.value == 0) return 0.0;
    return approvedItems.value / totalItems.value;
  }
}
