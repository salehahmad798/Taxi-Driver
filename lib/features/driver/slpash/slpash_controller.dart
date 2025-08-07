import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/routes/app_routes.dart';


class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {

    Timer(const Duration(seconds: 3), () async{

      // Get.offAllNamed(AppRoutes.onboarding);
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}