import 'package:get/get.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/features/driver/authentication/signup/signup_controller.dart';


class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }
}