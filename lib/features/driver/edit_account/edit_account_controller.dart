import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/models/user_model.dart';
import 'package:taxi_driver/features/driver/data/services/api_service.dart';
import 'package:taxi_driver/features/driver/data/services/storage_service.dart';

class EditAccountController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storage = Get.find<StorageService>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString profileImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get user data from arguments or storage
    final UserModel? user = Get.arguments;
    if (user != null) {
      nameController.text = user.name ?? '';
      emailController.text = user.email ?? '';
      phoneController.text = user.phone ?? '';
      profileImage.value = user.profileImage ?? '';
    } else {
      nameController.text = _storage.userName ?? '';
      emailController.text = _storage.userEmail ?? '';
      phoneController.text = _storage.userPhone ?? '';
      profileImage.value = _storage.userImage ?? '';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading(true);

      final updatedUser = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        profileImage: profileImage.value,
      );

      final success = await _apiService.updateUserProfile(updatedUser);
      
      if (success) {
        // Update storage
        _storage.userName = updatedUser.name;
        _storage.userEmail = updatedUser.email;
        _storage.userPhone = updatedUser.phone;
        _storage.userImage = updatedUser.profileImage;

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
      isLoading(false);
    }
  }

  void selectProfileImage() {
    // TODO: Implement image picker
    Get.snackbar('Info', 'Image picker feature coming soon');
  }
}