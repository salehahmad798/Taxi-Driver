import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/authentication/login/login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}