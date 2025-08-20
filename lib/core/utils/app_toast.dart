import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:taxi_driver/core/constants/app_colors.dart';

class AppToast {
  static successToast(msg, String message) {
    return Get.snackbar(
      'Success!', msg.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.lightGreen,
      colorText: Colors.white,
      maxWidth: Get.size.width * 0.8,
    );
  }

  static failToast(msg) {
    return Get.snackbar(
      'Oops!', msg.toString(),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent ,
      colorText: Colors.white,
      maxWidth: Get.size.width * 0.8,
    );
  }

  static infoToast(title, msg) {
    return Get.snackbar(
      '$title', msg.toString(),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.kprimaryColor,
      colorText: AppColors.backgroundColor,
      maxWidth: Get.size.width * 0.9,
    );
  }
}