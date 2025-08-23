import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/data/services/storage_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class OtpController extends GetxController {
  final ApiService apiService;
  final StorageService storageService;

  late final String phoneNumber;

  final otpController = TextEditingController();
  final otpError = RxnString();
  final generalError = RxnString();
  final isResendLoading = false.obs;
  final isOtpLoading = false.obs;

  OtpController(this.apiService, this.storageService);

  @override
  void onInit() {
    phoneNumber = Get.arguments['phone_number'] ?? '';
    if (phoneNumber.isEmpty) {
      generalError.value =
          "Phone number missing. Please go back and try again.";
    }
    super.onInit();
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
        otp: otpController.text.trim(),
        phoneNumber: phoneNumber,
      );

      if (resp.success) {
        if (resp.data != null) {
          // ========= save correct values =============
          await storageService.saveAccessToken(resp.data!.accessToken);
          await storageService.setTokenType(resp.data!.tokenType);
          await storageService.saveUser(resp.data!.user);

          log("✅ Token and user data saved");

          final isDocumentUploaded = resp.data!.isDocumentUploaded;
          final isVehicleInfoUploaded = resp.data!.isVehicleInformationUploaded;

          otpController.clear();

          // ====== Navigate ======
          // Get.offAllNamed(AppRoutes.documentUpload);

          if (isDocumentUploaded == true && isVehicleInfoUploaded == true) {
            Get.offAllNamed(AppRoutes.home); 
          } else {
            Get.offAllNamed(
              AppRoutes.documentUpload,
            ); 
          }
        } else {
          generalError.value = 'No data received';
        }
      } else {
        if (resp.errors != null) {
          if (resp.errors?['otp'] != null) {
            otpError.value = resp.errors?['otp'][0];
          } else if (resp.errors?['phone_number'] != null) {
            generalError.value = resp.errors?['phone_number'][0];
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

  Future<void> resendOtp() async {
    if (isResendLoading.value) return;

    isResendLoading.value = true;
    generalError.value = null;

    try {
      final resp = await apiService.resendOtp(phoneNumber: phoneNumber);
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
