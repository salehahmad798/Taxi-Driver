import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/providers/api_provider.dart';
import 'package:taxi_driver/features/driver/vehicle_registration/vehicle_registration_controller.dart';

class VehicleRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<VehicleRegistrationController>(
      () => VehicleRegistrationController(),
    );
  }
}