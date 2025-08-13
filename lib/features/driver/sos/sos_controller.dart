import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SosController extends GetxController {
  RxString currentAddress = '151-171 Montclair Ave Newark'.obs;

  void sendSos() {
    // Logic to alert emergency contact or service
  }
}