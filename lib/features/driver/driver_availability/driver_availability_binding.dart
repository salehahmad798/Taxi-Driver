import 'package:get/get.dart';

import 'package:taxi_driver/features/driver/driver_availability/driver_availability_controller.dart';

class DriverAvailabilityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverAvailabilityController>(() => DriverAvailabilityController());
  }
}