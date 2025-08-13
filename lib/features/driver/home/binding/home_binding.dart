import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<RideService>(() => RideService());
    // Get.lazyPut<DocumentService>(() => DocumentService());
    // Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
