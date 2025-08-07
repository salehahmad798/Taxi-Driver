import 'package:get/get.dart';

import 'package:taxi_driver/features/driver/break_mode/break_mode_controller.dart';

class BreakModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BreakModeController>(() => BreakModeController());
  }
}

