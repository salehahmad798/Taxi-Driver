
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/models/vehicle_photo_model.dart';
import 'dart:io';

import 'package:taxi_driver/features/driver/vehicle_details/vehicle_details_controller.dart';

class VehicleDetailsView extends GetView<VehicleDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Vehicle Details Upload',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.grey[600]),
            onPressed: () => _showHelpDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: Colors.white,
            child: Row(
              children: [
                _buildProgressStep(1, true, 'Document'),
                _buildProgressLine(true),
                _buildProgressStep(2, true, 'Photos'),
                _buildProgressLine(false),
                _buildProgressStep(3, false, 'Review'),
              ],
            ),
          ),

          // Upload Progress
          Obx(() => controller.isLoading.value
              ? Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        'Uploading ${controller.currentUploadingPhoto.value}...',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: controller.uploadProgress.value,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDC143C)),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink()),

          // Vehicle Photos Grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Photos',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          Obx(() => Text(
                                'Photos: ${controller.uploadedCount} / ${controller.vehiclePhotos.length}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              )),
                        ],
                      ),
                      Obx(() => CircularProgressIndicator(
                            value: controller.completionPercentage,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDC143C)),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),

                  Expanded(
                    child: Obx(() => GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: controller.vehiclePhotos.length,
                          itemBuilder: (context, index) {
                            final photo = controller.vehiclePhotos[index];
                            return _buildPhotoCard(photo);
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Obx(() => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.allRequiredPhotosUploaded
                        ? controller.proceedToNext
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.allRequiredPhotosUploaded
                          ? Color(0xFFDC143C)
                          : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: controller.allRequiredPhotosUploaded
                            ? Colors.white
                            : Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, bool isActive, String label) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isActive ? Color(0xFFDC143C) : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Color(0xFFDC143C) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: isActive ? Color(0xFFDC143C) : Colors.grey[300],
      ),
    );
  }

  Widget _buildPhotoCard(VehiclePhoto photo) {
    Color statusColor = _getStatusColor(photo.status);
    bool hasImage = photo.filePath != null || photo.serverUrl != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: photo.isRequired && photo.status == 'pending'
            ? Border.all(color: Colors.orange.withOpacity(0.5))
            : null,
      ),
      child: Column(
        children: [
          // Photo Area
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: hasImage
                  ? ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: photo.filePath != null
                          ? Image.file(
                              File(photo.filePath!),
                              fit: BoxFit.cover,
                            )
                          : photo.serverUrl != null
                              ? Image.network(
                                  photo.serverUrl!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(Icons.error, color: Colors.red),
                                    );
                                  },
                                )
                              : _buildPlaceholderContent(photo),
                    )
                  : _buildPlaceholderContent(photo),
            ),
          ),

          // Photo Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          photo.type,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (photo.isRequired)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Required',
                            style: TextStyle(
                              color: Colors.orange[700],
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    photo.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getStatusText(photo.status),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      _buildActionButton(photo),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderContent(VehiclePhoto photo) {
    return GestureDetector(
      onTap: () => controller.showImageSourceDialog(photo.type),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              photo.icon,
              size: 40,
              color: Colors.grey[400],
            ),
            SizedBox(height: 8),
            Text(
              'Tap to upload',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(VehiclePhoto photo) {
    switch (photo.status) {
      case 'pending':
        return GestureDetector(
          onTap: () => controller.showImageSourceDialog(photo.type),
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Color(0xFFDC143C),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
              size: 16,
            ),
          ),
        );
      case 'uploaded':
      case 'approved':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => _showImagePreview(photo),
              child: Container(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.visibility, color: Colors.blue, size: 16),
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () => controller.showImageSourceDialog(photo.type),
              child: Container(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.edit, color: Colors.orange, size: 16),
              ),
            ),
          ],
        );
      case 'failed':
        return GestureDetector(
          onTap: () => controller.showImageSourceDialog(photo.type),
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 16,
            ),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'uploaded':
        return Colors.blue;
      case 'approved':
        return Colors.green;
      case 'failed':
        return Colors.red;
      case 'uploading':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'uploaded':
        return 'Uploaded';
      case 'approved':
        return 'Approved';
      case 'failed':
        return 'Failed';
      case 'uploading':
        return 'Uploading';
      default:
        return 'Pending';
    }
  }

  void _showImagePreview(VehiclePhoto photo) {
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
                  child: photo.filePath != null
                      ? Image.file(
                          File(photo.filePath!),
                          width: Get.width * 0.8,
                          fit: BoxFit.cover,
                        )
                      : photo.serverUrl != null
                          ? Image.network(
                              photo.serverUrl!,
                              width: Get.width * 0.8,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: Get.width * 0.8,
                              height: 200,
                              child: Center(
                                child: Text('No image available'),
                              ),
                            ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: Text('Close'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      controller.showImageSourceDialog(photo.type);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDC143C),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Replace'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Photo Guidelines'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tips for better photos:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              _buildTipItem('📷', 'Take photos in good lighting'),
              _buildTipItem('🚗', 'Clean your vehicle before photographing'),
              _buildTipItem('📐', 'Keep the vehicle centered in frame'),
              _buildTipItem('🔍', 'Ensure photos are clear and not blurry'),
              _buildTipItem('📱', 'Hold phone steady when taking photos'),
              SizedBox(height: 10),
              Text(
                'Required photos must be uploaded to continue.',
                style: TextStyle(
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Got it'),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String emoji, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}