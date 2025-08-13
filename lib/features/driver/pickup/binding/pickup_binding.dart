import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/pickup/controller/pickup_controller.dart';


class PickupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickupController>(() => PickupController());
  }
}