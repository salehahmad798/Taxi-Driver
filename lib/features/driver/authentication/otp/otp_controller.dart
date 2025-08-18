// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:taxi_driver/data/services/api_service.dart';
// import 'package:taxi_driver/data/services/storage_service.dart';
// import 'package:taxi_driver/routes/app_routes.dart';

// class OtpController extends GetxController {
//   final ApiService apiService;
//   final StorageService storageService;

//   OtpController(this.apiService, this.storageService);

//   final otp = TextEditingController();
//   final isLoading = false.obs;
//   final otpError = RxnString();
//   final generalError = RxnString();

//   late final String phone;

//   @override
//   void onInit() {
//     phone = Get.arguments['phone'];
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     otp.dispose();
//     super.onClose();
//   }

//   bool _validateOtp() {
//     otpError.value = null;
//     if (otp.text.trim().isEmpty) {
//       otpError.value = "OTP is required";
//       return false;
//     }
//     return true;
//   }

//   Future<void> verifyOtp() async {
//     if (!_validateOtp()) return;
//     isLoading.value = true;

//     try {
//       final resp = await apiService.verifyOtp(
//         phone: phone,
//         otp: otp.text.trim(),
//       );

//       if (resp.success && resp.data != null) {
//         // Save token for later use
//         // await storageService.saveToken(resp.data!.token);
//         await storageService.saveRefreshToken(resp.data!.tokenType);

//         // Go to home screen
//         Get.offAllNamed(AppRoutes.home);
//       } else {
//         generalError.value = resp.message;
//       }
//     } catch (e) {
//       generalError.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> resendOtp() async {
//     try {
//       await apiService.resendOtp(phone: phone);
//     } catch (e) {
//       generalError.value = e.toString();
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/data/services/storage_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class OtpController extends GetxController {
  final ApiService apiService;
  final StorageService storageService;

  late final String phone;

  final otpController = TextEditingController();
  final otpError = RxnString();
  final generalError = RxnString();
  final isResendLoading = false.obs;
  final isOtpLoading = false.obs;

  OtpController(this.apiService, this.storageService);

  @override
  void onInit() {
    phone = Get.arguments['phone'] ?? '';
    super.onInit();
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  bool _validateOtp() {
    otpError.value = null;
    if (otpController.text.trim().isEmpty) {
      otpError.value = "OTP is required";
      return false;
    }
    return true;
  }
Future<void> verifyOtp() async {
  if (!_validateOtp()) return;

  isOtpLoading.value = true;
  generalError.value = null;
  otpError.value = null;

  try {
    final resp = await apiService.verifyOtp(
      phone: phone,
      otp: otpController.text.trim(),
    );

    if (resp.success) {
      if (resp.data != null) {
        await storageService.saveRefreshToken(resp.data!.tokenType);
        otpController.clear();
        Get.offAllNamed(AppRoutes.home);
      } else {
        generalError.value = 'No data received';
      }
    } else {
      // Handle validation errors
      if (resp.errors != null) {
        if (resp.errors?['phone_number'] != null) {
          generalError.value = resp.errors?['phone_number'][0];
        } else if (resp.errors?['otp'] != null) {
          otpError.value = resp.errors?['otp'][0];
        } else {
          generalError.value = resp.message ?? 'Verification failed';
        }
      } else {
        generalError.value = resp.message ?? 'Verification failed';
      }
    }
  } catch (e) {
    generalError.value = e.toString();
  } finally {
    isOtpLoading.value = false;
  }
}

  // Future<void> verifyOtp() async {
  //   if (!_validateOtp()) return;

  //   isOtpLoading.value = true;
  //   generalError.value = null;

  //   try {
  //     final resp = await apiService.verifyOtp(
  //       phone: phone,
  //       otp: otpController.text.trim(),
  //     );

  //     if (resp.success) {
  //       if (resp.data != null) {
  //         await storageService.saveRefreshToken(resp.data!.tokenType);
  //         otpController.clear(); // Clear OTP field after success
  //         Get.offAllNamed(AppRoutes.home);
  //       } else {
  //         generalError.value = 'No data received';
  //       }
  //     } else {
  //       generalError.value = resp.message ?? 'Verification failed';
  //     }
  //   } catch (e) {
  //     generalError.value = e.toString();
  //   } finally {
  //     isOtpLoading.value = false;
  //   }
  // }



  Future<void> resendOtp() async {
    if (isResendLoading.value) return;

    isResendLoading.value = true;
    generalError.value = null;

    try {
      final resp = await apiService.resendOtp(phone: phone);
      if (!resp.success) {
        generalError.value = resp.message ?? 'Failed to resend OTP';
      }
    } catch (e) {
      generalError.value = e.toString();
    } finally {
      isResendLoading.value = false;
    }
  }
}
