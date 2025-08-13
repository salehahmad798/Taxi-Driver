import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/about/about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
  }
}