import 'dart:developer';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_driver/core/utils/validators.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController {
  final ApiService apiService;

  SignupController(this.apiService);

  final isLoading = false.obs;
  final countryCode = '+92'.obs; // Default country code PK

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phone_number = TextEditingController();
  final password = TextEditingController();

  final firstNameError = RxnString();
  final lastNameError = RxnString();
  final emailError = RxnString();
  final phoneError = RxnString();
  final passwordError = RxnString();
  final generalError = RxnString();

  String get fullPhoneNumber => ValidationService.formatPhoneNumber(
    '${countryCode.value}${phone_number.text.trim()}',
  );

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone_number.dispose();
    password.dispose();
    super.onClose();
  }

  Future<Position?> _getLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      log('Location error: $e');
      return null;
    }
  }

  bool _validateFields() {
    firstNameError.value = ValidationService.getNameError(
      firstName.text.trim(),
      'First name',
    );
    lastNameError.value = ValidationService.getNameError(
      lastName.text.trim(),
      'Last name',
    );
    emailError.value = ValidationService.getEmailError(email.text.trim());
    phoneError.value = ValidationService.getPhoneError(
      phone_number.text.trim(),
    );
    passwordError.value = ValidationService.getPasswordError(
      password.text.trim(),
    );
    generalError.value = null;

    return firstNameError.value == null &&
        lastNameError.value == null &&
        emailError.value == null &&
        phoneError.value == null &&
        passwordError.value == null;
  }

  Future<void> register() async {
    if (!_validateFields()) {
      log(
        'Validation failed: '
        'firstName=${firstName.text}, lastName=${lastName.text}, email=${email.text}, phone=${fullPhoneNumber}',
      );
      return;
    }

    isLoading.value = true;
    log('Starting registration for phone: $fullPhoneNumber');

    try {
      final position = await _getLocation();
      log(
        'Location retrieved: lat=${position?.latitude}, lng=${position?.longitude}',
      );

      final resp = await apiService.registerDriver(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phone_number: fullPhoneNumber,
        password: password.text.trim(),
        latitude: position?.latitude ?? 31.5204,
        longitude: position?.longitude ?? 74.3587,
      );

      if (resp.success) {
        log('Registration success: ${resp.message}');
        Get.snackbar(
          'Success',
          resp.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.toNamed(
          AppRoutes.otp,
          arguments: {'phone': fullPhoneNumber.trim()},
        );

        // Clear all signup fields
        firstName.clear();
        lastName.clear();
        email.clear();
        phone_number.clear();
        password.clear();
      } else {
        // Handle API validation errors
        if (resp.errors != null) {
          log('API Validation Errors: ${resp.errors}');
          emailError.value = resp.errors?['email'] != null
              ? resp.errors!['email'][0]
              : null;
          phoneError.value = resp.errors?['phone_number'] != null
              ? resp.errors!['phone_number'][0]
              : null;

          // You can also set generalError for other API messages
          generalError.value = resp.message;
        } else {
          generalError.value = resp.message ?? 'Registration failed';
        }

        log('Registration failed: ${generalError.value}');
        Get.snackbar(
          'Error',
          generalError.value ?? 'Registration failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      generalError.value = 'An error occurred during registration';
      log('Registration exception: $e');
      Get.snackbar(
        'Error',
        generalError.value!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
