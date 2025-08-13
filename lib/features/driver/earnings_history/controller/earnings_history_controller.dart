import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/earnings_history/model/ride_history_model.dart';

class EarningsHistoryController extends GetxController {
  var selectedPeriod = 'Daily'.obs;
  var totalEarnings = 247.85.obs;
  var totalRides = 12.obs;
  var averagePerRide = 20.65.obs;
  var recentRides = <RideHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEarningsData();
  }

  void loadEarningsData() {
    // ================ Mock data ====================
    recentRides.value = [
      RideHistory(
        id: '1',
        time: DateTime.now().subtract(const Duration(hours: 2)),
        destination: 'Downtown Mall',
        distance: 5.2,
        earnings: 28.50,
        duration: 35,
      ),
      RideHistory(
        id: '2',
        time: DateTime.now().subtract(const Duration(hours: 4)),
        destination: 'Airport Terminal',
        distance: 12.4,
        earnings: 15.75,
        duration: 45,
      ),
    ];
  }

  void changePeriod(String period) {
    selectedPeriod.value = period;
    // =====================  Load data based on period ==================
    loadDataForPeriod(period);
  }

  void loadDataForPeriod(String period) {
    // ===========  Simulate different data for different periods ================== 
    switch (period) {
      case 'Daily':
        totalEarnings.value = 247.85;
        totalRides.value = 12;
        break;
      case 'Weekly':
        totalEarnings.value = 1847.32;
        totalRides.value = 89;
        break;
      case 'Monthly':
        totalEarnings.value = 7235.45;
        totalRides.value = 356;
        break;
    }
    averagePerRide.value = totalEarnings.value / totalRides.value;
  }

  void viewAllRides() {
    // ================  Navigate to detailed rides view ==================== 
    Get.toNamed('/rides-detail');
  }

  String formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} AM';
  }

  String formatDistance(double distance) {
    return '${distance.toStringAsFixed(1)} mi';
  }
}