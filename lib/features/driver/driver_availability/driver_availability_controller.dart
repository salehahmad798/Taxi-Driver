import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/models/availability_models.dart';

class DriverAvailabilityController extends GetxController {
  var isOnline = true.obs;
  var isBreakMode = false.obs;
  var dailySchedules = <DailySchedule>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeSchedule();
  }

  void initializeSchedule() {
    dailySchedules.value = [
      DailySchedule(day: 'Monday', isActive: true, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      DailySchedule(day: 'Tuesday', isActive: true, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      DailySchedule(day: 'Wednesday', isActive: true, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      DailySchedule(day: 'Thursday', isActive: false, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      DailySchedule(day: 'Friday', isActive: false, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      DailySchedule(day: 'Saturday', isActive: false, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      DailySchedule(day: 'Sunday', isActive: false, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
    ];
  }

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }

  void toggleBreakMode() {
    isBreakMode.value = !isBreakMode.value;
    Get.toNamed('/break-mode');
  }

  void toggleDaySchedule(int index) {
    dailySchedules[index] = dailySchedules[index].copyWith(
      isActive: !dailySchedules[index].isActive,
    );
  }

  void updateStartTime(int index, TimeOfDay time) {
    dailySchedules[index] = dailySchedules[index].copyWith(startTime: time);
  }

  void updateEndTime(int index, TimeOfDay time) {
    dailySchedules[index] = dailySchedules[index].copyWith(endTime: time);
  }

  void enableAllDays() {
    for (int i = 0; i < dailySchedules.length; i++) {
      dailySchedules[i] = dailySchedules[i].copyWith(isActive: true);
    }
  }

  void disableAllDays() {
    for (int i = 0; i < dailySchedules.length; i++) {
      dailySchedules[i] = dailySchedules[i].copyWith(isActive: false);
    }
  }

  Future<void> saveSchedule() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    Get.snackbar(
      'Success',
      'Schedule saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

