
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showHelpDialog() {
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


