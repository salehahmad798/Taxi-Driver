// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taxi_driver/routes/app_routes.dart';


// class SplashController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   late AnimationController animationController;

//   @override
//   void onInit() {
//     super.onInit();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..forward();

//     _navigateToNextScreen();
//   }

//   void _navigateToNextScreen() {

//     Timer(const Duration(seconds: 3), () async{

//       Get.offAllNamed(AppRoutes.onboarding);
//     });
//   }

//   @override
//   void onClose() {
//     animationController.dispose();
//     super.onClose();
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/data/services/storage_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  final StorageService storageService;

  SplashController(this.storageService);

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
    Timer(const Duration(seconds: 3), () async {
      final isFirst = await storageService.isFirstTimeUser();
      final isLoggedIn = await storageService.isLoggedIn();

      if (isFirst) {
        await storageService.setFirstTimeUser(false);
        Get.offAllNamed(AppRoutes.onboarding);
      } else if (isLoggedIn) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
