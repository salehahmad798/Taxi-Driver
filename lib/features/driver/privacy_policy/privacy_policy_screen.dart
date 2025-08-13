// lib/app/views/privacy_policy_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Text(
          'We value your privacy and are committed to protecting your personal information. '
          'This Privacy Policy explains how we collect, use, and safeguard your data.\n\n'
          '1. We collect data to improve our services.\n'
          '2. Your information will never be sold to third parties.\n'
          '3. You can request to delete your account at any time.\n'
          '4. We use secure encryption for all transactions.\n\n'
          'For detailed information, please contact our support team.',
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ),
    );
  }
}
