import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/models/review_models.dart';
import 'package:taxi_driver/features/driver/document_review/document_review_controller.dart';

class DocumentReviewView extends GetView<DocumentReviewController> {
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
          'Document Review',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.autoRefreshEnabled.value ? Icons.sync : Icons.sync_disabled,
                  color: controller.autoRefreshEnabled.value ? Colors.green : Colors.grey,
                ),
                onPressed: controller.toggleAutoRefresh,
                tooltip: controller.autoRefreshEnabled.value ? 'Auto-refresh ON' : 'Auto-refresh OFF',
              )),
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.blue),
            onPressed: controller.refreshData,
            tooltip: 'Refresh now',
          ),
        ],
      ),
      body: Column(
        children: [
          // Overall Status Card
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Obx(() => Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: controller.getStatusColor().withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            controller.getStatusIcon(),
                            color: controller.getStatusColor(),
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Review Status',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                controller.getStatusMessage(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Obx(() => LinearProgressIndicator(
                      value: controller.progressPercentage,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(controller.getStatusColor()),
                      minHeight: 8,
                    )),
                SizedBox(height: 12),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildProgressItem(
                          'Approved',
                          controller.approvedItems.value.toString(),
                          Colors.green,
                          Icons.check_circle,
                        ),
                        _buildProgressItem(
                          'Pending',
                          controller.pendingItems.value.toString(),
                          Colors.orange,
                          Icons.hourglass_empty,
                        ),
                        _buildProgressItem(
                          'Rejected',
                          controller.rejectedItems.value.toString(),
                          Colors.red,
                          Icons.cancel,
                        ),
                      ],
                    )),
              ],
            ),
          ),

          // Loading Indicator
          Obx(() => controller.refreshing.value
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text('Refreshing...', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )
              : SizedBox.shrink()),

          // Documents and Photos List
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: controller.refreshData,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.documents.isNotEmpty) ...[
                              _buildSectionHeader('Documents', Icons.description),
                              SizedBox(height: 10),
                              ...controller.documents.map((item) => _buildReviewItem(item)),
                              SizedBox(height: 20),
                            ],
                            if (controller.vehiclePhotos.isNotEmpty) ...[
                              _buildSectionHeader('Vehicle Photos', Icons.directions_car),
                              SizedBox(height: 10),
                              ...controller.vehiclePhotos.map((item) => _buildReviewItem(item)),
                              SizedBox(height: 20),
                            ],
                            if (controller.documents.isEmpty && controller.vehiclePhotos.isEmpty)
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 50),
                                    Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                                    SizedBox(height: 16),
                                    Text('No items to review'),
                                  ],
                                ),
                              ),
                            SizedBox(height: 100), // Extra space for FAB
                          ],
                        ),
                      ),
                    ),
                  )),
          ),
        ],
      ),
      floatingActionButton: Obx(() => controller.overallStatus.value == ReviewStatus.approved
          ? FloatingActionButton.extended(
              onPressed: controller.proceedToNext,
              backgroundColor: Colors.green,
              icon: Icon(Icons.arrow_forward, color: Colors.white),
              label: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : SizedBox.shrink()),
    );
  }

  Widget _buildProgressItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(ReviewItem item) {
    Color statusColor = _getItemStatusColor(item.status);
    IconData statusIcon = _getItemStatusIcon(item.status);
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(statusIcon, color: statusColor, size: 24),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            if (item.isRequired)
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getStatusText(item.status),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (item.reviewNotes != null) ...[
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.feedback, size: 14, color: Colors.red[600]),
                        SizedBox(width: 4),
                        Text(
                          'Review Notes:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.red[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      item.reviewNotes!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red[800],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (item.uploadDate != null) ...[
              SizedBox(height: 4),
              Text(
                'Uploaded: ${_formatDate(item.uploadDate!)}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
        trailing: _buildItemAction(item),
        onTap: () => _showItemDetails(item),
      ),
    );
  }

  Widget _buildItemAction(ReviewItem item) {
    switch (item.status) {
      case ReviewStatus.rejected:
        return ElevatedButton(
          onPressed: () => controller.resubmitItem(item),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFDC143C),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          child: Text(
            'Resubmit',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        );
      case ReviewStatus.approved:
        return Icon(Icons.check_circle, color: Colors.green, size: 24);
      case ReviewStatus.underReview:
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      default:
        return Icon(Icons.hourglass_empty, color: Colors.orange, size: 24);
    }
  }

  Color _getItemStatusColor(ReviewStatus status) {
    switch (status) {
      case ReviewStatus.approved:
        return Colors.green;
      case ReviewStatus.rejected:
        return Colors.red;
      case ReviewStatus.underReview:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getItemStatusIcon(ReviewStatus status) {
    switch (status) {
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

  String _getStatusText(ReviewStatus status) {
    switch (status) {
      case ReviewStatus.approved:
        return 'Approved';
      case ReviewStatus.rejected:
        return 'Rejected';
      case ReviewStatus.underReview:
        return 'Under Review';
      default:
        return 'Pending';
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  void _showItemDetails(ReviewItem item) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
              margin: EdgeInsets.only(bottom: 20),
            ),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            _buildDetailRow('Type', item.type == ReviewItemType.document ? 'Document' : 'Vehicle Photo'),
            _buildDetailRow('Status', _getStatusText(item.status)),
            if (item.uploadDate != null)
              _buildDetailRow('Upload Date', _formatDate(item.uploadDate!)),
            if (item.reviewDate != null)
              _buildDetailRow('Review Date', _formatDate(item.reviewDate!)),
            if (item.reviewNotes != null) ...[
              SizedBox(height: 16),
              Text(
                'Review Notes:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Text(
                  item.reviewNotes!,
                  style: TextStyle(
                    color: Colors.red[800],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
            SizedBox(height: 20),
            if (item.status == ReviewStatus.rejected)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    controller.resubmitItem(item);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDC143C),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Resubmit Item',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
