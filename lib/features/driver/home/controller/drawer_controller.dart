// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taxi_driver/features/driver/data/models/user_model.dart';
// import 'package:taxi_driver/features/driver/data/services/api_service.dart';
// import 'package:taxi_driver/features/driver/data/services/storage_service.dart';
// import 'package:taxi_driver/routes/app_routes.dart';

// class DrawerController extends GetxController {
//   final StorageService _storage = Get.find<StorageService>();
//   final ApiService _apiService = Get.find<ApiService>();

//   final Rx<UserModel> user = UserModel().obs;
//   final RxBool isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadUserData();
//   }

//   void loadUserData() {
//     // Load user data from storage first
//     user.value = UserModel(
//       name: _storage.userName,
//       email: _storage.userEmail,
//       phone: _storage.userPhone,
//       profileImage: _storage.userImage,
//     );

//     // Then fetch updated data from API
//     fetchUserProfile();
//   }

//   Future<void> fetchUserProfile() async {
//     try {
//       isLoading(true);
//       final userProfile = await _apiService.getUserProfile();
//       if (userProfile != null) {
//         user(userProfile);
//         // Update storage
//         _storage.userName = userProfile.name;
//         _storage.userEmail = userProfile.email;
//         _storage.userPhone = userProfile.phone;
//         _storage.userImage = userProfile.profileImage;
//       }
//     } catch (e) {
//       print('Error fetching user profile: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

//   void navigateToMyAccount() {
//     Get.back(); // Close drawer
//     Get.toNamed(AppRoutes.myAccount);
//   }

//   void navigateToUpdateVehicle() {
//     Get.back();
//     // Navigate to update vehicle screen
//     Get.snackbar('Info', 'Update Vehicle Info feature coming soon');
//   }

//   void navigateToEarnings() {
//     Get.back();
//     // Navigate to earnings screen
//     Get.snackbar('Info', 'Earnings feature coming soon');
//   }

//   void navigateToManageDocuments() {
//     Get.back();
//     // Navigate to manage documents screen
//     Get.snackbar('Info', 'Manage Documents feature coming soon');
//   }

//   void navigateToFAQ() {
//     Get.back();
//     Get.toNamed(AppRoutes.faq);
//   }

//   void navigateToCustomerReviews() {
//     Get.back();
//     Get.toNamed(AppRoutes.customerReviews);
//   }

//   void navigateToSOS() {
//     Get.back();
//     Get.toNamed(AppRoutes.sos);
//   }

//   void navigateToNotification() {
//     Get.back();
//     Get.toNamed(AppRoutes.notification);
//   }

//   void navigateToAbout() {
//     Get.back();
//     Get.toNamed(AppRoutes.about);
//   }

//   void navigateToPrivacyPolicy() {
//     Get.back();
//     // Navigate to privacy policy
//     Get.snackbar('Info', 'Privacy Policy feature coming soon');
//   }

//   void navigateToTermsCondition() {
//     Get.back();
//     // Navigate to terms condition
//     Get.snackbar('Info', 'Terms & Condition feature coming soon');
//   }

//   void logout() {
//     Get.dialog(
//       AlertDialog(
//         title: Text('Logout'),
//         content: Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               _storage.clearUserData();
//               Get.back(); // Close dialog
//               Get.back(); // Close drawer
//               // Navigate to login screen
//               Get.offAllNamed('/login');
//             },
//             child: Text('Logout', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/routes/app_routes.dart';

// Dummy UserModel for demonstration
class UserModel {
  final String? name;
  final String? phone;
  final String? profileImage;

  UserModel({this.name, this.phone, this.profileImage});
}

class DrawerController extends GetxController {
  // User observable
  final Rx<UserModel> user = UserModel(
    name: 'Frank Smith',
    phone: '+234 1234567891',
    profileImage: null,
  ).obs;

  // ========== Navigation handlers - replace with your real navigation logic ==========
  void navigateToMyAccount() {
    Get.snackbar('Navigation', 'Navigating to My Account');
    Get.toNamed(AppRoutes.myAccount);
  }

  void navigateToUpdateVehicle() {
    Get.back();
    Get.snackbar('Info', 'Update Vehicle Info feature coming soon');
    Get.toNamed(AppRoutes.updateVehicle);
  }

  void navigateToEarnings() {
     Get.toNamed(AppRoutes.earningsHistory);
    // Get.back();
    Get.snackbar('Info', 'Earnings feature coming soon');
  
  }

  void navigateToManageDocuments() {
    Get.back();
    Get.snackbar('Info', 'Manage Documents feature coming soon');
  }

  void navigateToFAQ() {
     Get.toNamed(AppRoutes.faq);
   
    Get.snackbar('Navigation', 'Navigating to FAQ');
  }

  void navigateToCustomerReviews() {
     Get.toNamed(AppRoutes.customerReviews);
    Get.snackbar('Navigation', 'Navigating to Customer Reviews');
  }

  void navigateToSOS() {
    Get.toNamed(AppRoutes.sos);
    Get.snackbar('Navigation', 'Navigating to SOS');
  }

  void navigateToNotification() {
    Get.toNamed(AppRoutes.notification);
    Get.snackbar('Navigation', 'Navigating to Notification');
  }

  void navigateToAbout() {
    Get.toNamed(AppRoutes.about);
    Get.snackbar('Navigation', 'Navigating to About');
  }

  void navigateToPrivacyPolicy() {
    Get.toNamed(AppRoutes.privacyPolicy);
    Get.snackbar('Info', 'Privacy Policy feature coming soon');
  }

  void navigateToTermsCondition() {
    Get.toNamed(AppRoutes.termsCondition);
    Get.snackbar('Info', 'Terms & Condition feature coming soon');
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // Clear storage or user data here if any
              Get.back(); // close dialog
           
              Get.offAllNamed(AppRoutes.login);
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.primaryappcolor)),
          ),
        ],
      ),
    );
  }
}
