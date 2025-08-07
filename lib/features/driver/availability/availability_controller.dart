import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailabilityMainController extends GetxController {
  var currentStatus = 'Available'.obs;
  var workingHours = '8h 30m'.obs;

  void navigateToDriverAvailability() {
    Get.toNamed('/driver-availability');
  }

  void navigateToBreakMode() {
    Get.toNamed('/break-mode');
  }

  void navigateToEarningsHistory() {
    Get.toNamed('/earnings-history');
  }
}
