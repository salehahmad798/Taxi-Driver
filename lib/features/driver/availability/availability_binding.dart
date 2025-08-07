import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/availability/availability_controller.dart';

class AvailabilityMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvailabilityMainController>(() => AvailabilityMainController());
  }
}