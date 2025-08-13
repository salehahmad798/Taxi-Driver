// lib/app/views/terms_conditions_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Text(
          'By using our services, you agree to the following terms:\n\n'
          '1. You must provide accurate and up-to-date information.\n'
          '2. Our service is not responsible for any loss or damage during rides.\n'
          '3. Payment must be completed before the ride starts.\n'
          '4. You must comply with local laws and regulations.\n'
          '5. We reserve the right to suspend accounts that violate these terms.\n\n'
          'Please read these terms carefully before using our services.',
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ),
    );
  }
}
