// lib/features/driver/account/edit_account/edit_account_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/data/models/user_model.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/data/services/storage_service.dart';

class EditAccountController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storage = Get.find<StorageService>();

  /// Form & Controllers
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  /// State
  final isLoading = false.obs;
  final profileImage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    /// Try to get user from navigation arguments
    final UserModel? user = Get.arguments;
    if (user != null) {
      nameController.text = user.name ?? '';
      emailController.text = user.email ?? '';
      phoneController.text = user.phone ?? '';
      profileImage.value = user.profileImage ?? '';
    } else {
      /// Fallback to stored user data
      // nameController.text = _storage.userName ?? '';
      // emailController.text = _storage.userEmail ?? '';
      // phoneController.text = _storage.userPhone ?? '';
      // profileImage.value = _storage.userImage ?? '';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  /// Update Profile API call
  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final updatedUser = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        profileImage: profileImage.value,
      );

      final success = await _apiService.updateUserProfile(updatedUser);

      if (success) {
        /// Save changes locally
        // _storage.userName = updatedUser.name;
        // _storage.userEmail = updatedUser.email;
        // _storage.userPhone = updatedUser.phone;
        // _storage.userImage = updatedUser.profileImage;
        
        /// Go back with result
        Get.back(result: updatedUser);

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to update profile',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error updating profile: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Image Picker (to implement later)
  void selectProfileImage() {
    // TODO: Implement image picker
    Get.snackbar('Info', 'Image picker feature coming soon');
  }
}
