import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/models/break_session_model.dart';

class BreakModeController extends GetxController {
  var isOnBreak = false.obs;
  var breakSessions = <BreakSession>[].obs;
  var currentBreakDuration = 0.obs; // in minutes
  var selectedQuickBreak = 0.obs; // 0 = none, 15, 30, 60, 120
  var customBreakDuration = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadBreakSessions();
  }

  @override
  void onClose() {
    customBreakDuration.dispose();
    super.onClose();
  }

  void loadBreakSessions() {
    // Mock data - replace with API call
    breakSessions.value = [];
  }

  void toggleBreakMode() {
    if (isOnBreak.value) {
      endBreak();
    } else {
      startQuickBreak(2);
    }
  }

  void startQuickBreak(int minutes) {
    selectedQuickBreak.value = minutes;
    currentBreakDuration.value = minutes;
    _startBreakSession(minutes);
  }

  void startCustomBreak() {
    final duration = int.tryParse(customBreakDuration.text) ?? 0;
    if (duration > 0) {
      currentBreakDuration.value = duration;
      _startBreakSession(duration);
      customBreakDuration.clear();
    }
  }

  void _startBreakSession(int duration) {
    isOnBreak.value = true;
    final session = BreakSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: DateTime.now(),
      duration: duration,
      isActive: true,
    );
    breakSessions.add(session);
    
    // Start timer for break duration
    _startBreakTimer(duration);
  }

  void _startBreakTimer(int minutes) {
    // This would typically use a Timer or similar mechanism
    // For demo purposes, we'll just simulate the break ending after the duration
  }

  void endBreak() {
    if (breakSessions.isNotEmpty) {
      final currentSession = breakSessions.last;
      if (currentSession.isActive) {
        final updatedSession = currentSession.copyWith(
          endTime: DateTime.now(),
          isActive: false,
        );
        breakSessions[breakSessions.length - 1] = updatedSession;
      }
    }
    
    isOnBreak.value = false;
    currentBreakDuration.value = 0;
    selectedQuickBreak.value = 0;
    
    Get.snackbar(
      'Break Ended',
      'You are now available for rides',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  String get breakStatusText {
    if (isOnBreak.value) {
      return "You're currently online and available for rides";
    }
    return "You're currently online and available for rides";
  }
}