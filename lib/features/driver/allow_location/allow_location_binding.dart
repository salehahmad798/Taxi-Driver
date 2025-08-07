import 'package:get/get.dart';

import 'allow_location_controller.dart';

class AllowLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllowLocationController>(() => AllowLocationController());
  }
}