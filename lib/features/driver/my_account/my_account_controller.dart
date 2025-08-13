
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/models/user_model.dart';
import 'package:taxi_driver/features/driver/data/services/api_service.dart';
import 'package:taxi_driver/features/driver/data/services/storage_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class MyAccountController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storage = Get.find<StorageService>();
  
  final Rx<UserModel> user = UserModel().obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading(true);
      error('');
      
      // Load from storage first
      user.value = UserModel(
        name: _storage.userName,
        email: _storage.userEmail,
        phone: _storage.userPhone,
        profileImage: _storage.userImage,
      );

      // Then fetch from API
      final userProfile = await _apiService.getUserProfile();
      if (userProfile != null) {
        user(userProfile);
        // Update storage
        _storage.userName = userProfile.name;
        _storage.userEmail = userProfile.email;
        _storage.userPhone = userProfile.phone;
        _storage.userImage = userProfile.profileImage;
      } else {
        error('Failed to load user profile');
      }
    } catch (e) {
      error('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  void navigateToEditProfile() {
    Get.toNamed(AppRoutes.editAccount, arguments: user.value);
  }

  void navigateToHistory() {
    Get.toNamed(AppRoutes.history);
  }

  void navigateToWallet() {
    Get.toNamed(AppRoutes.wallet);
  }

  Future<void> deleteAccount() async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete account API call
              Get.back();
              Get.snackbar('Info', 'Delete account functionality will be implemented');
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    Get.dialog(
      AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _storage.clearUserData();
              Get.back();
              Get.offAllNamed('/login');
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
