import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/data/models/document_model.dart';


import 'dart:io';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class DocumentUploadController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService(Get.find());

  var documents = <DocumentModel>[].obs;
  var isLoading = false.obs;
  var uploadProgress = 0.0.obs;

  // Track selected files
  File? drivingLicence;
  File? idCardFront;
  File? idCardBack;
  File? passport;
  File? vehicleRegistration;
  File? vehicleFrontPhoto;
  File? vehicleRearPhoto;
  File? driverSide;
  File? interior;

  final requiredDocuments = [
    'Driving License',
    'ID Card Front',
    'ID Card Back',
    'Passport',
    'Vehicle Registration',
    'Vehicle Front Photo',
    'Vehicle Rear Photo',
    'Driver Side',
    'Interior',
  ];

  @override
  void onInit() {
    super.onInit();
    initializeDocuments();
  }

  void initializeDocuments() {
    documents.value = requiredDocuments
        .map(
          (type) => DocumentModel(
            id: DateTime.now().millisecondsSinceEpoch.toString() +
                type.replaceAll(" ", ""),
            type: type,
            isRequired: true,
            status: "pending",
            uploadDate: null,
          ),
        )
        .toList();
  }

  /// Pick image for a specific document
  Future<void> pickImage(String documentType, ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        final file = File(image.path);

        switch (documentType) {
          case "Driving License":
            drivingLicence = file;
            break;
          case "ID Card Front":
            idCardFront = file;
            break;
          case "ID Card Back":
            idCardBack = file;
            break;
          case "Passport":
            passport = file;
            break;
          case "Vehicle Registration":
            vehicleRegistration = file;
            break;
          case "Vehicle Front Photo":
            vehicleFrontPhoto = file;
            break;
          case "Vehicle Rear Photo":
            vehicleRearPhoto = file;
            break;
          case "Driver Side":
            driverSide = file;
            break;
          case "Interior":
            interior = file;
            break;
        }

        updateDocumentStatus(documentType, "selected", file.path);
      }
    } catch (e) {
      debugPrint(" Image Pick Error: $e");
      Get.snackbar("Error", "Failed to pick image: $e",
          backgroundColor: Colors.red[100], colorText: Colors.red[800]);
    }
  }

  /// Upload all documents together (API requires all mandatory files at once)
  Future<void> uploadAllDocuments() async {
    if (vehicleFrontPhoto == null ||
        vehicleRearPhoto == null ||
        driverSide == null ||
        interior == null) {
      Get.snackbar("Error", "Please upload all required vehicle photos first",
          backgroundColor: Colors.red[100], colorText: Colors.red[800]);
      return;
    }

    isLoading.value = true;
    uploadProgress.value = 0.2;

    try {
      final response = await _apiService.uploadDocument(
        drivingLicence: drivingLicence,
        idCardFront: idCardFront,
        idCardBack: idCardBack,
        passport: passport,
        vehicleRegistration: vehicleRegistration,
        vehicleFrontPhoto: vehicleFrontPhoto!,
        vehicleRearPhoto: vehicleRearPhoto!,
        driverSide: driverSide!,
        interior: interior!,
      );

      debugPrint(" API Response Code: ${response.statusCode}");
      debugPrint(" API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Mark all as uploaded
        for (var doc in documents) {
          doc.status = "uploaded";
          doc.uploadDate = DateTime.now().toIso8601String();
        }
        documents.refresh();

        Get.snackbar("Success", "All documents uploaded successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green[100],
            colorText: Colors.green[800]);
      } else {
        Get.snackbar("Error", "Upload failed: ${response.body}",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[100],
            colorText: Colors.red[800]);
      }
    } catch (e) {
      debugPrint("Upload Exception: $e");
      Get.snackbar("Error", "Failed to upload: $e",
          backgroundColor: Colors.red[100], colorText: Colors.red[800]);
    } finally {
      isLoading.value = false;
      uploadProgress.value = 0.0;
    }
  }

  /// Update status in the UI
  void updateDocumentStatus(String type, String status, [String? filePath]) {
    final index = documents.indexWhere((d) => d.type == type);
    if (index != -1) {
      documents[index].status = status;
      if (filePath != null) {
        documents[index].filePath = filePath;
      }
      if (status == "uploaded") {
        documents[index].uploadDate = DateTime.now().toIso8601String();
      }
      documents.refresh();
    }
  }

  bool get allDocumentsUploaded {
    final requiredDocs = documents.where((d) => d.isRequired).toList();
    return requiredDocs.isNotEmpty &&
        requiredDocs.every(
          (d) => d.status == "uploaded" || d.status == "approved",
        );
  }

  void proceedToNext() {
    if (allDocumentsUploaded) {
      Get.snackbar("Next Step", "Proceeding to Vehicle registration...",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue[100],
          colorText: Colors.blue[800]);
      // Get.toNamed('/vehicle-details');
      Get.toNamed(AppRoutes.vehicleRegistration);

    } else {
      Get.snackbar("Incomplete", "Please upload all required documents",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange[100],
          colorText: Colors.orange[800]);
    }
  }

  /// Show image picker options
  void showImageSourceDialog(String documentType) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
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
            const SizedBox(height: 20),
            Text('Upload $documentType',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Get.back();
                    pickImage(documentType, ImageSource.camera);
                  },
                ),
                _buildSourceOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Get.back();
                    pickImage(documentType, ImageSource.gallery);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16)),
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
        padding: const EdgeInsets.symmetric(vertical: 20),
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
                color: const Color(0xFFDC143C).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: const Color(0xFFDC143C)),
            ),
            const SizedBox(height: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}



// class DocumentUploadController extends GetxController {
//   final ApiProvider _apiProvider = Get.find<ApiProvider>();
//   final ImagePicker _picker = ImagePicker();
  
//   var documents = <DocumentModel>[].obs;
//   var isLoading = false.obs;
//   var uploadProgress = 0.0.obs;
//   var currentUploadingDocument = ''.obs;
  
//   final requiredDocuments = [
//     'Driving License',
//     'Vehicle Registration',
//     'Insurance Certificate',
//     'Profile Photo',
//     'Background Check',
//   ];

//   @override
//   void onInit() {
//     super.onInit();
//     initializeDocuments();
//     loadExistingDocuments();
//   }

//   void initializeDocuments() {
//     documents.value = requiredDocuments.map((type) => DocumentModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString() + type.replaceAll(' ', ''),
//       type: type,
//       isRequired: true,
//       status: 'pending',
//       uploadDate: null,
//     )).toList();
//   }

//   Future<void> loadExistingDocuments() async {
//     try {
//       isLoading.value = true;
//       final response = await _apiProvider.getDocuments();
      
//       if (response.isOk && response.body != null) {
//         final List<dynamic> documentsJson = response.body['documents'] ?? [];
//         final existingDocs = documentsJson
//             .map((json) => DocumentModel.fromJson(json))
//             .toList();
        
//         // Update existing documents with server data
//         for (var existingDoc in existingDocs) {
//           final index = documents.indexWhere((doc) => doc.type == existingDoc.type);
//           if (index != -1) {
//             documents[index] = existingDoc;
//           }
//         }
//         documents.refresh();
//       }
//     } catch (e) {
//       print('Error loading documents: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> pickImage(String documentType, ImageSource source) async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: source,
//         maxWidth: 1920,
//         maxHeight: 1920,
//         imageQuality: 85,
//       );
      
//       if (image != null) {
//         // Validate image size (max 5MB)
//         final file = File(image.path);
//         final fileSizeInBytes = await file.length();
//         final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        
//         if (fileSizeInMB > 5) {
//           Get.snackbar(
//             'Error', 
//             'Image size should be less than 5MB',
//             snackPosition: SnackPosition.TOP,
//             backgroundColor: Colors.red[100],
//             colorText: Colors.red[800],
//           );
//           return;
//         }
        
//         await uploadDocument(image.path, documentType);
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error', 
//         'Failed to pick image: ${e.toString()}',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red[100],
//         colorText: Colors.red[800],
//       );
//     }
//   }

//   Future<void> uploadDocument(String filePath, String documentType) async {
//     currentUploadingDocument.value = documentType;
//     isLoading.value = true;
//     uploadProgress.value = 0.0;
    
//     // Update UI immediately to show uploading state
//     updateDocumentStatus(documentType, 'uploading', filePath);
    
//     try {
//       // Simulate progress for better UX
//       _simulateUploadProgress();
      
//       final response = await _apiProvider.uploadDocument(filePath, documentType);
      
//       if (response.isOk) {
//         final documentData = response.body;
//         updateDocumentWithServerData(documentType, documentData, filePath);
        
//         Get.snackbar(
//           'Success', 
//           'Document uploaded successfully',
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.green[100],
//           colorText: Colors.green[800],
//           icon: Icon(Icons.check_circle, color: Colors.green),
//         );
//       } else {
//         updateDocumentStatus(documentType, 'failed');
//         Get.snackbar(
//           'Error', 
//           response.body['message'] ?? 'Failed to upload document',
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.red[100],
//           colorText: Colors.red[800],
//         );
//       }
//     } catch (e) {
//       updateDocumentStatus(documentType, 'failed');
//       Get.snackbar(
//         'Error', 
//         'Network error occurred. Please check your connection.',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red[100],
//         colorText: Colors.red[800],
//       );
//     } finally {
//       isLoading.value = false;
//       uploadProgress.value = 0.0;
//       currentUploadingDocument.value = '';
//     }
//   }

//   void _simulateUploadProgress() {
//     uploadProgress.value = 0.0;
//     for (int i = 1; i <= 10; i++) {
//       Future.delayed(Duration(milliseconds: i * 100), () {
//         if (uploadProgress.value < 0.9) {
//           uploadProgress.value = i * 0.1;
//         }
//       });
//     }
//   }

//   void updateDocumentStatus(String type, String status, [String? filePath]) {
//     final index = documents.indexWhere((doc) => doc.type == type);
//     if (index != -1) {
//       documents[index].status = status;
//       if (filePath != null) {
//         documents[index].filePath = filePath;
//       }
//       if (status == 'uploaded') {
//         documents[index].uploadDate = DateTime.now().toIso8601String();
//       }
//       documents.refresh();
//     }
//   }

//   void updateDocumentWithServerData(String type, Map<String, dynamic> serverData, String filePath) {
//     final index = documents.indexWhere((doc) => doc.type == type);
//     if (index != -1) {
//       documents[index] = DocumentModel(
//         id: serverData['id']?.toString(),
//         type: type,
//         status: serverData['status'] ?? 'uploaded',
//         filePath: filePath,
//         uploadDate: serverData['upload_date'] ?? DateTime.now().toIso8601String(),
//         reviewDate: serverData['review_date'],
//         reviewNotes: serverData['review_notes'],
//         isRequired: documents[index].isRequired,
//       );
//       documents.refresh();
//     }
//   }

//   void showImageSourceDialog(String documentType) {
//     Get.bottomSheet(
//       Container(
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Upload $documentType',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildSourceOption(
//                   icon: Icons.camera_alt,
//                   label: 'Camera',
//                   onTap: () {
//                     Get.back();
//                     pickImage(documentType, ImageSource.camera);
//                   },
//                 ),
//                 _buildSourceOption(
//                   icon: Icons.photo_library,
//                   label: 'Gallery',
//                   onTap: () {
//                     Get.back();
//                     pickImage(documentType, ImageSource.gallery);
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             TextButton(
//               onPressed: () => Get.back(),
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }



//   Widget _buildSourceOption({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 120,
//         padding: EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey[300]!),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Color(0xFFDC143C).withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 icon, 
//                 size: 24, 
//                 color: Color(0xFFDC143C),
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   bool get allDocumentsUploaded {
//     final requiredDocs = documents.where((doc) => doc.isRequired).toList();
//     return requiredDocs.isNotEmpty && 
//            requiredDocs.every((doc) => 
//              doc.status == 'uploaded' || 
//              doc.status == 'approved'
//            );
//   }

//   int get uploadedCount {
//     return documents.where((doc) => 
//       doc.status == 'uploaded' || 
//       doc.status == 'approved'
//     ).length;
//   }

//   int get totalRequiredCount {
//     return documents.where((doc) => doc.isRequired).length;
//   }

//   double get completionPercentage {
//     if (totalRequiredCount == 0) return 0.0;
//     return uploadedCount / totalRequiredCount;
//   }

//   void proceedToNext() {
//     if (allDocumentsUploaded) {
//       Get.toNamed('/vehicle-details');
//     } else {
//       Get.snackbar(
//         'Incomplete', 
//         'Please upload all required documents to continue',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.orange[100],
//         colorText: Colors.orange[800],
//         icon: Icon(Icons.warning, color: Colors.orange),
//       );
//     }
//   }

//   void retryFailedUploads() {
//     final failedDocs = documents.where((doc) => doc.status == 'failed').toList();
//     for (var doc in failedDocs) {
//       if (doc.filePath != null) {
//         uploadDocument(doc.filePath!, doc.type!);
//       }
//     }
//   }

//   @override
//   void onClose() {
//     // Clean up resources
//     super.onClose();
//   }
// }