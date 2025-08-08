// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taxi_driver/features/driver/data/models/document_model.dart';
// import 'package:taxi_driver/features/driver/document_upload/document_upload_controller.dart';
// import 'dart:io';

// class DocumentUploadView extends GetView<DocumentUploadController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'My Document',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Progress Indicator
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             color: Colors.white,
//             child: Row(
//               children: [
//                 _buildProgressStep(1, true, 'Document'),
//                 _buildProgressLine(true),
//                 _buildProgressStep(2, false, 'Review'),
//                 _buildProgressLine(false),
//                 _buildProgressStep(3, false, 'Complete'),
//               ],
//             ),
//           ),
          
//           // Document List
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Required Documents',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'Please upload all required documents',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: 20),
                  
//                   Expanded(
//                     child: Obx(() => ListView.builder(
//                       itemCount: controller.documents.length,
//                       itemBuilder: (context, index) {
//                         final document = controller.documents[index];
//                         return _buildDocumentCard(document);
//                       },
//                     )),
//                   ),
//                 ],
//               ),
//             ),
//           ),
          
//           // Bottom Button
//           Container(
//             padding: EdgeInsets.all(20),
//             color: Colors.white,
//             child: Obx(() => SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: controller.allDocumentsUploaded
//                     ? controller.proceedToNext
//                     : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: controller.allDocumentsUploaded
//                       ? Color(0xFFDC143C)
//                       : Colors.grey[300],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Continue',
//                   style: TextStyle(
//                     color: controller.allDocumentsUploaded
//                         ? Colors.white
//                         : Colors.grey[600],
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             )),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProgressStep(int step, bool isActive, String label) {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             width: 30,
//             height: 30,
//             decoration: BoxDecoration(
//               color: isActive ? Color(0xFFDC143C) : Colors.grey[300],
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 step.toString(),
//                 style: TextStyle(
//                   color: isActive ? Colors.white : Colors.grey[600],
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: isActive ? Color(0xFFDC143C) : Colors.grey[600],
//               fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProgressLine(bool isActive) {
//     return Expanded(
//       child: Container(
//         height: 2,
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         color: isActive ? Color(0xFFDC143C) : Colors.grey[300],
//       ),
//     );
//   }

//   Widget _buildDocumentCard(DocumentModel document) {
//     Color statusColor = _getStatusColor(document.status ?? 'pending');
//     IconData statusIcon = _getStatusIcon(document.status ?? 'pending');
    
//     return Container(
//       margin: EdgeInsets.only(bottom: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: statusColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             statusIcon,
//             color: statusColor,
//             size: 24,
//           ),
//         ),
//         title: Text(
//           document.type ?? '',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 5),
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: statusColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     _getStatusText(document.status ?? 'pending'),
//                     style: TextStyle(
//                       color: statusColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 if (document.isRequired) ...[
//                   SizedBox(width: 8),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.orange.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       'Required',
//                       style: TextStyle(
//                         color: Colors.orange[700],
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//             if (document.status == 'uploaded' && document.filePath != null) ...[
//               SizedBox(height: 8),
//               Text(
//                 'File uploaded successfully',
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ],
//         ),
//         trailing: _buildActionButton(document),
//       ),
//     );
//   }

//   Widget _buildActionButton(DocumentModel document) {
//     switch (document.status) {
//       case 'pending':
//         return ElevatedButton(
//           onPressed: () => controller.showImageSourceDialog(document.type!),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFFDC143C),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           ),
//           child: Text(
//             'Upload',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         );
//       case 'uploaded':
//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               onPressed: () => _showImagePreview(document.filePath!),
//               icon: Icon(Icons.visibility, color: Colors.blue),
//               iconSize: 20,
//             ),
//             IconButton(
//               onPressed: () => controller.showImageSourceDialog(document.type!),
//               icon: Icon(Icons.edit, color: Colors.orange),
//               iconSize: 20,
//             ),
//           ],
//         );
//       case 'approved':
//         return Icon(Icons.check_circle, color: Colors.green, size: 24);
//       case 'rejected':
//         return TextButton(
//           onPressed: () => controller.showImageSourceDialog(document.type!),
//           child: Text(
//             'Re-upload',
//             style: TextStyle(
//               color: Color(0xFFDC143C),
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         );
//       default:
//         return SizedBox.shrink();
//     }
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'uploaded':
//         return Colors.blue;
//       case 'approved':
//         return Colors.green;
//       case 'rejected':
//         returnAppColors.kprimaryColor;
//       default:
//         return Colors.grey;
//     }
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status) {
//       case 'uploaded':
//         return Icons.cloud_upload;
//       case 'approved':
//         return Icons.check_circle;
//       case 'rejected':
//         return Icons.error;
//       default:
//         return Icons.upload_file;
//     }
//   }

//   String _getStatusText(String status) {
//     switch (status) {
//       case 'uploaded':
//         return 'Uploaded';
//       case 'approved':
//         return 'Approved';
//       case 'rejected':
//         return 'Rejected';
//       default:
//         return 'Pending';
//     }
//   }

//   void _showImagePreview(String imagePath) {
//     Get.dialog(
//       Dialog(
//         backgroundColor: Colors.transparent,
//         child: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.file(
//                     File(imagePath),
//                     width: Get.width * 0.8,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => Get.back(),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                 ),
//                 child: Text('Close'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/primary_button.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class DocumentUploadScreen extends StatelessWidget {
  final documents = [
    {
      'title': 'Driving license',
      'subtitle': 'A Driving license is an official document',
      'optional': false,
    },
    {
      'title': 'ID card',
      'subtitle': 'ID card is an official document',
      'optional': false,
    },
    {
      'title': 'Passport',
      'subtitle': 'A passport is an travel document',
      'optional': true,
    },
    {
      'title': 'Vehicle Registration',
      'subtitle': 'Enter your vehicle details',
      'optional': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  'My Document',
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.separated(
                  itemCount: documents.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                    final uploaded = index == 0; 
                    return DocumentCard(
                      title: doc['title'].toString(),
                      subtitle: doc['subtitle'].toString(),
                
                      isOptional: false,
                      isUploaded: uploaded,
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  '* These field are required',
                  style: TextStyle(fontSize: 14.sp, color:AppColors.kprimaryColor),
                ),
              ),
              SizedBox(height: 16.h),
              PrimaryButton(text: 'Next',width: double.infinity, onTap: (){


                Get.toNamed(AppRoutes.vehicleRegistration);
              }),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isOptional;
  final bool isUploaded;

  const DocumentCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.isOptional = false,
    this.isUploaded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4.r,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title ${isOptional ? "(Optional)" : ""}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: isUploaded ?AppColors.kprimaryColor : Colors.grey.shade300,
            radius: 18.r,
            child: Icon(
              Icons.upload_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
