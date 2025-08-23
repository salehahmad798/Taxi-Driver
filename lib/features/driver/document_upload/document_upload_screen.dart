import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/data/models/document_model.dart';
import 'package:taxi_driver/features/driver/document_upload/document_upload_controller.dart';
import 'dart:io';

class DocumentUploadScreen extends GetView<DocumentUploadController> {
  const DocumentUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Get.back(),
        // ),
        title: Text(
          'My Document',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // =================== Progress Indicator ==================
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: Colors.white,
            child: Row(
              children: [
                _buildProgressStep(1, true, 'Document'),
                _buildProgressLine(true),
                _buildProgressStep(2, false, 'Review'),
                _buildProgressLine(false),
                _buildProgressStep(3, false, 'Complete'),
              ],
            ),
          ),

          // ==================  Document List ====================
          SizedBox(height: 6.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Required Documents',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  // SizedBox(height: 5.h),
                  Text(
                    '* Please upload all required documents',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.kprimaryColor,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.documents.length,
                        itemBuilder: (context, index) {
                          final document = controller.documents[index];
                          return _buildDocumentCard(document);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================  Bottom Button ================
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.allDocumentsUploaded) {
                      controller.proceedToNext();
                    } else {
                      // await controller.uploadSingleDocument(document, file);
                      await controller.uploadAllDocuments();

                      if (controller.allDocumentsUploaded) {
                        controller.proceedToNext();
                      } else {
                        Get.snackbar(
                          'Upload Required',
                          'Please upload all required documents before continuing.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.allDocumentsUploaded
                        ? AppColors.kprimaryColor
                        : Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: controller.allDocumentsUploaded
                          ? Colors.white
                          : Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, bool isActive, String label) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? AppColors.kprimaryColor : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isActive ? AppColors.kprimaryColor : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: isActive ? AppColors.kprimaryColor : Colors.grey[300],
      ),
    );
  }

  Widget _buildDocumentCard(DocumentModel document) {
    Color statusColor = _getStatusColor(document.status ?? 'pending');
    IconData statusIcon = _getStatusIcon(document.status ?? 'pending');

    // String _getDocumentDescription() {
    //   switch (document.type?.toLowerCase()) {
    //     case 'driving license':
    //       return 'A driving license is an official document';
    //     case 'id card':
    //       return 'An ID card is an official document';
    //     case 'passport':
    //       return 'A passport is a travel document';
    //     case 'vehicle details':
    //       return 'Enter your vehicle details';
    //     default:
    //       return 'Enter your vehicle details';
    //   }
    // }
    String _getDocumentDescription(String type) {
      switch (type.toLowerCase()) {
        case 'driving license':
          return 'Upload your valid Driving License';
        case 'id card front':
          return 'Upload the front side of your ID card';
        case 'id card back':
          return 'Upload the back side of your ID card';
        case 'passport':
          return 'Upload your Passport (valid)';
        case 'vehicle registration':
          return 'Upload your Vehicle Registration Certificate';
        case 'vehicle front photo':
          return 'Upload a clear photo of your vehicle front';
        case 'vehicle rear photo':
          return 'Upload a clear photo of your vehicle rear';
        case 'driver side':
          return 'Upload a clear photo of driver’s side';
        case 'interior':
          return 'Upload a photo of the vehicle interior';
        default:
          return 'Upload required document';
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _getContainerColor(document.status ?? ''),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            _getStatusIcon(document.status ?? ''),
            color: _getIconColor(document.status ?? ''),
            size: 24,
          ),
        ),
        title: Text(
          document.type ?? '',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),

            // ============  New part: Show message or description ===============
            if (document.status == 'uploaded')
              Text(
                'File uploaded successfully',
                style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
              )
            else
              Text(
                _getDocumentDescription(document.type ?? ''),
                style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
              ),

            SizedBox(height: 6),

            //  =================== Status badges Row ========================
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(document.status ?? 'pending'),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                if (document.isRequired)
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Required',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        trailing: _buildActionButton(document),
      ),
    );
  }

  Widget _buildActionButton(DocumentModel document) {
    switch (document.status) {
      case 'pending':
        return ElevatedButton(
          onPressed: () => controller.showImageSourceDialog(document.type!),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kprimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            'Upload',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      case 'uploaded':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _showImagePreview(document.filePath!),
              icon: Icon(Icons.visibility, color: AppColors.primaryappcolor),
              iconSize: 20,
            ),
            IconButton(
              onPressed: () => controller.showImageSourceDialog(document.type!),
              icon: Icon(Icons.edit, color: AppColors.kprimaryColor),
              iconSize: 20,
            ),
          ],
        );
      case 'approved':
        return Icon(Icons.check_circle, color: Colors.green, size: 24);
      case 'rejected':
        return TextButton(
          onPressed: () => controller.showImageSourceDialog(document.type!),
          child: Text(
            'Re-upload',
            style: TextStyle(
              color: AppColors.kprimaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  // Color _getStatusColor(String status) {
  //   switch (status) {
  //     case 'uploaded':
  //       return AppColors.primaryappcolor;
  //     case 'approved':
  //       return Colors.green;
  //     case 'rejected':
  //       return AppColors.kredColor;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  // IconData _getStatusIcon(String status) {
  //   switch (status) {
  //     case 'uploaded':
  //       return Icons.done;
  //     case 'approved':
  //       return Icons.check_circle;
  //     case 'rejected':
  //       return Icons.error;
  //     default:
  //       return Icons.upload_file;
  //   }
  // }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'uploaded':
        return AppColors.primaryappcolor;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return AppColors.kredColor;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'uploaded':
        return Icons.done;
      case 'approved':
        return Icons.check_circle;
      case 'rejected':
        return Icons.error;
      default:
        return Icons.upload_file;
    }
  }

  Color _getIconColor(String status) {
    if (status == 'uploaded') {
      return Colors.white;
    }
    return _getStatusColor(status);
  }

  Color _getContainerColor(String status) {
    if (status == 'uploaded') {
      return AppColors.primaryappcolor;
    }
    return _getStatusColor(status).withOpacity(0.1);
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'uploaded':
        return 'Uploaded';
      case 'approved':
        return 'Approved';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Pending';
    }
  }

  void _showImagePreview(String imagePath) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(imagePath),
                    width: Get.width * 0.8,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}  


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:taxi_driver/core/constants/app_colors.dart';
// import 'package:taxi_driver/core/widgets/primary_button.dart';
// import 'package:taxi_driver/routes/app_routes.dart';

// class DocumentUploadScreen extends StatelessWidget {
//   final documents = [
//     {
//       'title': 'Driving license',
//       'subtitle': 'A Driving license is an official document',
//       'optional': false,
//     },
//     {
//       'title': 'ID card',
//       'subtitle': 'ID card is an official document',
//       'optional': false,
//     },
//     {
//       'title': 'Passport',
//       'subtitle': 'A passport is an travel document',
//       'optional': true,
//     },
//     {
//       'title': 'Vehicle Registration',
//       'subtitle': 'Enter your vehicle details',
//       'optional': false,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20.h),
//               Center(
//                 child: Text(
//                   'My Document',
//                   style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(height: 24.h),
//               Expanded(
//                 child: ListView.separated(
//                   itemCount: documents.length,
//                   separatorBuilder: (_, __) => SizedBox(height: 12.h),
//                   itemBuilder: (context, index) {
//                     final doc = documents[index];
//                     final uploaded = index == 0; 
//                     return DocumentCard(
//                       title: doc['title'].toString(),
//                       subtitle: doc['subtitle'].toString(),
                
//                       isOptional: false,
//                       isUploaded: uploaded,
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               Padding(
//                 padding: EdgeInsets.only(left: 8.w),
//                 child: Text(
//                   '* These field are required',
//                   style: TextStyle(fontSize: 14.sp, color:AppColors.kprimaryColor),
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               PrimaryButton(text: 'Next',width: double.infinity, onTap: (){


//                 Get.toNamed(AppRoutes.vehicleRegistration);
//               }),
//               SizedBox(height: 16.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DocumentCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final bool isOptional;
//   final bool isUploaded;

//   const DocumentCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     this.isOptional = false,
//     this.isUploaded = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade300,
//             blurRadius: 4.r,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '$title ${isOptional ? "(Optional)" : ""}',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   subtitle,
//                   style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//           CircleAvatar(
//             backgroundColor: isUploaded ?AppColors.kprimaryColor : Colors.grey.shade300,
//             radius: 18.r,
//             child: Icon(
//               Icons.upload_rounded,
//               color: Colors.white,
//               size: 20.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }







