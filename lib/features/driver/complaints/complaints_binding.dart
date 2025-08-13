import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/complaints/complaints_controller.dart';

class ComplaintsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintsController>(() => ComplaintsController());
  }
}
