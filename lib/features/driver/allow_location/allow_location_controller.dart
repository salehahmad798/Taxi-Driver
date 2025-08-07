import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class AllowLocationController extends GetxController {
  RxBool locationEnabled = false.obs;

  Future<void> requestLocationPermission(BuildContext context) async {
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

    // ✅ Permission granted — now get location and navigate
    locationEnabled.value = true;
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Optional: print position or store it
    print('Location: ${position.latitude}, ${position.longitude}');

    // ================= Navigate to login screen ====================
    Get.offAllNamed(AppRoutes.login);
  }

  void _showLocationDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Location Permission'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
