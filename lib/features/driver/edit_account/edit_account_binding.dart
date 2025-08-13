import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/edit_account/edit_account_controller.dart';

class EditAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAccountController>(() => EditAccountController());
  }
}