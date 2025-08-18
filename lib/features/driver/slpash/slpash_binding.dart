import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/slpash/slpash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(Get.find()));
  }
}