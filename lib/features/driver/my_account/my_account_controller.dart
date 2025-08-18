import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/data/models/user_model.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/data/services/storage_service.dart';
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

  /// Load user profile from storage and API
  Future<void> loadUserProfile() async {
    try {
      isLoading(true);
      error('');

      // Load cached user from storage first
      // user.value = UserModel(
      //   name: _storage.userName,
      //   email: _storage.userEmail,
      //   phone: _storage.userPhone,
      //   profileImage: _storage.userImage,
      // );

      // Then fetch latest from API
      final userProfile = await _apiService.getUserProfile();
      if (userProfile != null) {
        user(userProfile);

        // Update storage for next session
        // _storage.userName = userProfile.name;
        // _storage.userEmail = userProfile.email;
        // _storage.userPhone = userProfile.phone;
        // _storage.userImage = userProfile.profileImage;
      } else {
        error('Failed to load user profile');
      }
    } catch (e) {
      error('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Navigate to edit profile
  void navigateToEditProfile() {
    Get.toNamed(AppRoutes.editAccount, arguments: user.value);
  }

  void navigateToHistory() {
    Get.toNamed(AppRoutes.history);
  }

  void navigateToWallet() {
    Get.toNamed(AppRoutes.wallet);
  }

  /// Delete account (to be implemented later with API)
  Future<void> deleteAccount() async {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete account API call
              Get.back();
              Get.snackbar('Info', 'Delete account functionality will be implemented');
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// Logout user — clear storage and tokens
  Future<void> logout() async {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // ✅ Clear both tokens and user data
              // await _storage.removeToken();
              
              await _storage.removeRefreshToken();
              // await _storage.clearUserData();

              Get.back();
              Get.offAllNamed(AppRoutes.login);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
