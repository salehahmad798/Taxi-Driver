import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_driver/core/utils/app_toast.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class SignupController extends GetxController {
  // =========== Form controllers ===========
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumberController = TextEditingController(); 

  // =========== Validation errors ===========
  final firstNameError = RxnString();
  final lastNameError = RxnString();
  final emailError = RxnString();
  final phoneError = RxnString();
  final generalError = RxnString();

  // =========== State ===========
  final isLoading = false.obs;
  double? latitude;
  double? longitude;

  /// ============== Dial code + number → full international phone number =========
  String fullPhoneNumber = '';
  String dialCode = "+92";

  // ApiService instance
  final ApiService apiService = Get.find<ApiService>();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 300), () {
      _requestLocationPermission(Get.context!);
    });
  }

  //  ============ inside SignupController ===========
  void setPhoneNumber(String number, String dial) {
    fullPhoneNumber = number; 
    dialCode = dial; 
    log("📱 Full Phone: $fullPhoneNumber | Dial code: $dial");
  }

  Future<void> _requestLocationPermission(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationDialog("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationDialog("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationDialog(
        "Location permission permanently denied.\nEnable it from app settings.",
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = position.latitude;
    longitude = position.longitude;
    log("User location: $latitude, $longitude");
  }

  void _showLocationDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Location Permission'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('OK')),
        ],
      ),
    );
  }

  /// ============== Called from UI button ========
  Future<void> register() async {
    //  =============== Clear errors first =====================================
    firstNameError.value = null;
    lastNameError.value = null;
    emailError.value = null;
    phoneError.value = null;
    generalError.value = null;

    final firstNameText = firstName.text.trim();
    final lastNameText = lastName.text.trim();
    final emailText = email.text.trim();

    if (firstNameText.isEmpty) firstNameError.value = "First name is required";
    if (lastNameText.isEmpty) lastNameError.value = "Last name is required";
    if (emailText.isEmpty) emailError.value = "Email is required";
    if (fullPhoneNumber.isEmpty) phoneError.value = "Phone number is required";

    if (firstNameError.value != null ||
        lastNameError.value != null ||
        emailError.value != null ||
        phoneError.value != null ||
        generalError.value != null) {
      return;
    }

    if (latitude == null || longitude == null) {
      generalError.value = "Please allow location access before signing up.";
      return;
    }

    isLoading.value = true;

    try {
      final response = await apiService.registerDriver(
        firstName: firstNameText,
        lastName: lastNameText,
        email: emailText,
        // phoneNumber: fullPhoneNumber, // Fixed parameter name
        latitude: latitude!,
        longitude: longitude!, phone_number: fullPhoneNumber,
      );

      log("Signup response: ${response.message}");

      if (response.success && response.data != null) {
        AppToast.successToast("Success", response.message);
        log("Signup successful: ${response.message}");
        
        // Extract OTP and user ID from response
        final otpCode = response.data!.data.otpCode;
        final userId = response.data!.data.userId;

        Get.toNamed(
          AppRoutes.otp,
          arguments: {
            "phone_number": fullPhoneNumber,
            "otp_code": otpCode,
            "user_id": userId,
          },
        );
      } else {
        _handleRegistrationError(response);
      }
    } catch (e) {
      log('Register Error in Controller: $e');
      generalError.value = "Network error occurred";
      AppToast.failToast("Network error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  void _handleRegistrationError(dynamic response) {
    try {
      if (response.errors != null && response.errors!.isNotEmpty) {
        final errors = response.errors!; 
        final firstKey = errors.keys.first;
        final firstErrorMessage = (errors[firstKey] as List).first;

        switch (firstKey) {
          case "first_name":
            firstNameError.value = firstErrorMessage;
            break;
          case "last_name":
            lastNameError.value = firstErrorMessage;
            break;
          case "email":
            emailError.value = firstErrorMessage;
            break;
          case "phone_number":
            phoneError.value = firstErrorMessage;
            break;
          default:
            generalError.value = firstErrorMessage;
        }

        AppToast.failToast(firstErrorMessage);
      } else {
        generalError.value = response.message ?? "Registration failed";
        AppToast.failToast(response.message ?? "Registration failed");
      }
    } catch (e) {
      generalError.value = "Something went wrong.";
      AppToast.failToast("Something went wrong.");
    }
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}