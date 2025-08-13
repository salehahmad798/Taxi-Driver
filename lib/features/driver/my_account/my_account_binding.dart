import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/my_account/my_account_controller.dart';

class MyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAccountController>(() => MyAccountController());
  }
}