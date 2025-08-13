import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/home/controller/drawer_controller.dart';

class DrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawerController>(() => DrawerController());
  }
}