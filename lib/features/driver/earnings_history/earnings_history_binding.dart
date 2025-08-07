import 'package:get/get.dart';


import 'package:taxi_driver/features/driver/earnings_history/earnings_history_controller.dart';

class EarningsHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EarningsHistoryController>(() => EarningsHistoryController());
  }
}
