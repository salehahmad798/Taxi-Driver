import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/sos/sos_controller.dart';

class SosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SosController>(() => SosController());
  }
}