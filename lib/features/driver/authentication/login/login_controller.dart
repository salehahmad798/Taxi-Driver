// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taxi_driver/data/services/api_service.dart';
// import 'package:taxi_driver/routes/app_routes.dart';

// class LoginController extends GetxController {
//   final ApiService apiService;
//   LoginController(this.apiService);

//   final phone = TextEditingController();
//   final phoneFocus = FocusNode();

//   final isLoading = false.obs;
//   final phoneError = RxnString();
//   final generalError = RxnString();

//   @override
//   void onClose() {
//     phone.dispose();
//     phoneFocus.dispose();
//     super.onClose();
//   }

//   bool _validateFields() {
//     phoneError.value = null;
//     if (phone.text.trim().isEmpty) {
//       phoneError.value = "Phone number is required";
//       return false;
//     }
//     return true;
//   }

//   Future<void> login() async {
//     if (!_validateFields()) return;
//     isLoading.value = true;

//     try {
//       final resp = await apiService.loginDriver(identifier: phone.text.trim());

//       if (resp.success) {
//         // Navigate to OTP screen with phone number
//         Get.toNamed(AppRoutes.otp, arguments: {'phone': phone.text.trim()});
//       } else {
//         generalError.value = resp.message;
//       }
//     } catch (e) {
//       generalError.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class LoginController extends GetxController {
  final ApiService apiService;

  LoginController(this.apiService);

  final phone = TextEditingController();
  final dialCode = "+92".obs; // default Pakistan, can be changed by user
  final phoneError = RxnString();
  final generalError = RxnString();
  final isLoading = false.obs;

  @override
  void onClose() {
    phone.dispose();
    super.onClose();
  }

  bool _validateFields() {
    phoneError.value = null;
    if (phone.text.trim().isEmpty) {
      phoneError.value = "Phone number is required";
      return false;
    }
    return true;
  }

  Future<void> login() async {
    if (!_validateFields()) return;

    isLoading.value = true;
    generalError.value = null;

    // Combine dial code + phone number (remove leading 0 if present)
    String phoneNumber = phone.text.trim();
    if (phoneNumber.startsWith("0")) {
      phoneNumber = phoneNumber.substring(1);
    }
    final fullNumber = "${dialCode.value}$phoneNumber";

    try {
      final resp = await apiService.loginDriver(identifier: fullNumber);

      // Debug logs
      print('Login Request Number: $fullNumber');
      print('Login Response: ${resp.success} - ${resp.message}');
      print('Raw API data: ${resp.data}');

      if (resp.success) {
        Get.toNamed(
          AppRoutes.otp,
          arguments: {'phone_number': fullNumber}, // ✅ use phone_number
        );
        phone.clear();
      } else {
        generalError.value = resp.message ?? "Login failed. Try again.";
        print('Login failed: ${resp.message}, errors: ${resp.errors}');
      }
    } catch (e) {
      generalError.value = "Network error. Please try again later.";
      print('Login Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
