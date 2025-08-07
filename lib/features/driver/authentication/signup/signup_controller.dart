// signup_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class SignupController extends GetxController {
  // TextEditingControllers for each field
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  

  // Password visibility toggle (if needed in future)
  final isLoading = false.obs;

  // Validation and submission logic
  void submitSignupForm() {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    // Perform signup logic (API call, etc.)
    isLoading.value = true;

    // Mock delay
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar("Success", "Account created successfully!");
      // Get.toNamed(AppRoutes.otp); 
    });
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
