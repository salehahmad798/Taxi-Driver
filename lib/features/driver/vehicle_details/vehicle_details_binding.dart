
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/providers/api_provider.dart';
import 'package:taxi_driver/features/driver/vehicle_details/vehicle_details_controller.dart';

class VehicleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // API Provider for making HTTP requests
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );

    // Vehicle Details Controller
    Get.lazyPut<VehicleDetailsController>(
      () => VehicleDetailsController(),
    );
  }
}