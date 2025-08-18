import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/data/models/vehicle_model.dart';
import 'package:taxi_driver/data/providers/api_provider.dart';

class VehicleRegistrationController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  final formKey = GlobalKey<FormState>();

  // Form controllers
  final drivingLicenseController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final colorController = TextEditingController();
  final engineNumberController = TextEditingController();
  final chassisNumberController = TextEditingController();
  final ownerAddressController = TextEditingController();
  final ownernameController = TextEditingController();
  


  // Observable variables
RxString selectedFuelType = ''.obs;
  var registrationDate = Rx<DateTime?>(null);
  var expiryDate = Rx<DateTime?>(null);
  var isLoading = false.obs;

  RxString selectedVehicleType = ''.obs;

  // Example vehicle types with icon and name
  final vehicleTypes = [
    {'name': 'Car', 'icon': Icons.directions_car},
    {'name': 'Bike', 'icon': Icons.motorcycle},
    {'name': 'Van', 'icon': Icons.airport_shuttle},
    {'name': 'Truck', 'icon': Icons.fire_truck_outlined},
    {'name': 'Bus', 'icon': Icons.bus_alert_rounded},
    {'name': 'other', 'icon': Icons.car_crash_outlined},

  ];

  void setVehicleType(String typeName) {
    selectedVehicleType.value = typeName;
  }

  RxList<String> fuelTypes = ['Petrol', 'Diesel', 'Electric', 'Hybrid', 'CNG', 'LPG'].obs;


void setFuelType(String type) {
  selectedFuelType.value = type;
}


  // Dropdown options
  // final vehicleTypes = ['Car', 'Motorcycle', 'Truck', 'Van'];
  // final fuelTypes = ['Petrol', 'Diesel', 'Electric', 'Hybrid'];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    drivingLicenseController.dispose();
    makeController.dispose();
    modelController.dispose();
    yearController.dispose();
    colorController.dispose();
    engineNumberController.dispose();
    chassisNumberController.dispose();
    ownerAddressController.dispose();
    super.onClose();
  }



  void setRegistrationDate(DateTime date) {
    registrationDate.value = date;
  }

  void setExpiryDate(DateTime date) {
    expiryDate.value = date;
  }

  Future<void> submitVehicleRegistration() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final vehicle = VehicleModel(
        drivingLicense: drivingLicenseController.text,
        vehicleType: selectedVehicleType.value,
        make: makeController.text,
        model: modelController.text,
        year: yearController.text,
        color: colorController.text,
        fuelType: selectedFuelType.value,
        engineNumber: engineNumberController.text,
        chassisNumber: chassisNumberController.text,
        ownerAddress: ownerAddressController.text,
        registrationDate: registrationDate.value?.toIso8601String(),
        expiryDate: expiryDate.value?.toIso8601String(),
      );

      final response = await _apiProvider.registerVehicle(
         vehicle.toJson(),
      );

      if (response.isOk) {
        Get.snackbar('Success', 'Vehicle registered successfully');
        Get.offNamed('/document-upload');
      } else {
        Get.snackbar('Error', 'Failed to register vehicle');
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
