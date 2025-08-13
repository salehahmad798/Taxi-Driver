import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class AvailabilityMainController extends GetxController {
  var currentStatus = 'Available'.obs;
  var workingHours = '8h 30m'.obs;

  void navigateToDriverAvailability() {
    Get.toNamed(AppRoutes.driverAvailability);
  }

  void navigateToBreakMode() {
    Get.toNamed(AppRoutes.breakMode);
  }

  void navigateToEarningsHistory() {
    Get.toNamed(AppRoutes.earningsHistory);
  }
}
