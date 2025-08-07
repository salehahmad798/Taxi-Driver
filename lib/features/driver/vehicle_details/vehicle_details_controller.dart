
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/features/driver/data/models/vehicle_photo_model.dart';
import 'dart:io';

import 'package:taxi_driver/features/driver/data/providers/api_provider.dart';

class VehicleDetailsController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final ImagePicker _picker = ImagePicker();

  // Observable variables
  var vehiclePhotos = <VehiclePhoto>[].obs;
  var isLoading = false.obs;
  var uploadProgress = 0.0.obs;
  var currentUploadingPhoto = ''.obs;

  // Required photo types
  final requiredPhotoTypes = [
    PhotoType('Front View', 'Take a clear photo of vehicle front', Icons.directions_car, true),
    PhotoType('Rear View', 'Take a clear photo of vehicle rear', Icons.directions_car, true),
    PhotoType('Left Side', 'Take a photo from left side', Icons.directions_car, true),
    PhotoType('Right Side', 'Take a photo from right side', Icons.directions_car, true),
    PhotoType('Interior', 'Take a photo of vehicle interior', Icons.airline_seat_recline_normal, true),
    PhotoType('Dashboard', 'Take a photo of dashboard', Icons.dashboard, true),
    PhotoType('Engine Bay', 'Take a photo of engine compartment', Icons.build, false),
    PhotoType('Trunk/Boot', 'Take a photo of trunk/boot space', Icons.luggage, false),
  ];

  @override
  void onInit() {
    super.onInit();
    initializePhotoList();
    loadExistingPhotos();
  }

  void initializePhotoList() {
    vehiclePhotos.value = requiredPhotoTypes
        .map((type) => VehiclePhoto(
              id: DateTime.now().millisecondsSinceEpoch.toString() + type.name.replaceAll(' ', ''),
              type: type.name,
              description: type.description,
              icon: type.icon,
              isRequired: type.isRequired,
              status: 'pending',
            ))
        .toList();
  }

  Future<void> loadExistingPhotos() async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getVehiclePhotos();

      if (response.isOk && response.body != null) {
        final List<dynamic> photosJson = response.body['photos'] ?? [];
        final existingPhotos = photosJson
            .map((json) => VehiclePhoto.fromJson(json))
            .toList();

        // Update existing photos with server data
        for (var existingPhoto in existingPhotos) {
          final index = vehiclePhotos.indexWhere((photo) => photo.type == existingPhoto.type);
          if (index != -1) {
            vehiclePhotos[index] = existingPhoto;
          }
        }
        vehiclePhotos.refresh();
      }
    } catch (e) {
      print('Error loading vehicle photos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(String photoType, ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        // Validate image size (max 10MB)
        final file = File(image.path);
        final fileSizeInBytes = await file.length();
        final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

        if (fileSizeInMB > 10) {
          Get.snackbar(
            'Error',
            'Image size should be less than 10MB',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[100],
            colorText: Colors.red[800],
          );
          return;
        }

        await uploadVehiclePhoto(image.path, photoType);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    }
  }

  Future<void> uploadVehiclePhoto(String filePath, String photoType) async {
    currentUploadingPhoto.value = photoType;
    isLoading.value = true;
    uploadProgress.value = 0.0;

    // Update UI immediately to show uploading state
    updatePhotoStatus(photoType, 'uploading', filePath);

    try {
      // Simulate progress for better UX
      _simulateUploadProgress();

      final response = await _apiProvider.uploadVehiclePhoto(filePath, photoType);

      if (response.isOk) {
        final photoData = response.body;
        updatePhotoWithServerData(photoType, photoData, filePath);

        Get.snackbar(
          'Success',
          'Vehicle photo uploaded successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
          icon: Icon(Icons.check_circle, color: Colors.green),
        );
      } else {
        updatePhotoStatus(photoType, 'failed');
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to upload photo',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
        );
      }
    } catch (e) {
      updatePhotoStatus(photoType, 'failed');
      Get.snackbar(
        'Error',
        'Network error occurred. Please check your connection.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    } finally {
      isLoading.value = false;
      uploadProgress.value = 0.0;
      currentUploadingPhoto.value = '';
    }
  }

  void _simulateUploadProgress() {
    uploadProgress.value = 0.0;
    for (int i = 1; i <= 10; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (uploadProgress.value < 0.9) {
          uploadProgress.value = i * 0.1;
        }
      });
    }
  }

  void updatePhotoStatus(String type, String status, [String? filePath]) {
    final index = vehiclePhotos.indexWhere((photo) => photo.type == type);
    if (index != -1) {
      vehiclePhotos[index].status = status;
      if (filePath != null) {
        vehiclePhotos[index].filePath = filePath;
      }
      if (status == 'uploaded') {
        vehiclePhotos[index].uploadDate = DateTime.now().toIso8601String();
      }
      vehiclePhotos.refresh();
    }
  }

  void updatePhotoWithServerData(String type, Map<String, dynamic> serverData, String filePath) {
    final index = vehiclePhotos.indexWhere((photo) => photo.type == type);
    if (index != -1) {
      vehiclePhotos[index] = VehiclePhoto(
        id: serverData['id']?.toString() ?? vehiclePhotos[index].id,
        type: type,
        description: vehiclePhotos[index].description,
        icon: vehiclePhotos[index].icon,
        status: serverData['status'] ?? 'uploaded',
        filePath: filePath,
        serverUrl: serverData['url'],
        uploadDate: serverData['upload_date'] ?? DateTime.now().toIso8601String(),
        isRequired: vehiclePhotos[index].isRequired,
      );
      vehiclePhotos.refresh();
    }
  }

  void showImageSourceDialog(String photoType) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Upload $photoType',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Get.back();
                    pickImage(photoType, ImageSource.camera);
                  },
                ),
                _buildSourceOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Get.back();
                    pickImage(photoType, ImageSource.gallery);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFDC143C).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: Color(0xFFDC143C),
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get allRequiredPhotosUploaded {
    final requiredPhotos = vehiclePhotos.where((photo) => photo.isRequired).toList();
    return requiredPhotos.isNotEmpty &&
        requiredPhotos.every((photo) =>
            photo.status == 'uploaded' ||
            photo.status == 'approved');
  }

  int get uploadedCount {
    return vehiclePhotos
        .where((photo) =>
            photo.status == 'uploaded' ||
            photo.status == 'approved')
        .length;
  }

  int get totalRequiredCount {
    return vehiclePhotos.where((photo) => photo.isRequired).length;
  }

  double get completionPercentage {
    if (totalRequiredCount == 0) return 0.0;
    return uploadedCount / totalRequiredCount;
  }

  void proceedToNext() {
    if (allRequiredPhotosUploaded) {
      Get.toNamed('/document-review');
    } else {
      Get.snackbar(
        'Incomplete',
        'Please upload all required vehicle photos to continue',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange[100],
        colorText: Colors.orange[800],
        icon: Icon(Icons.warning, color: Colors.orange),
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
