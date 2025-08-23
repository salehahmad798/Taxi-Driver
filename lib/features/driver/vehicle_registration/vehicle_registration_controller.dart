import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/data/models/vehicle_model.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class VehicleRegistrationController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

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

  // Vehicle types
  final vehicleTypes = [
    {'name': 'Car', 'icon': Icons.directions_car},
    {'name': 'Bike', 'icon': Icons.motorcycle},
    {'name': 'Van', 'icon': Icons.airport_shuttle},
    {'name': 'Truck', 'icon': Icons.fire_truck_outlined},
    {'name': 'Bus', 'icon': Icons.bus_alert_rounded},
    {'name': 'Other', 'icon': Icons.car_crash_outlined},
  ];

  void setVehicleType(String typeName) {
    selectedVehicleType.value = typeName;
  }

  RxList<String> fuelTypes =
      ['Petrol', 'Diesel', 'Electric', 'Hybrid', 'CNG', 'LPG'].obs;

  void setFuelType(String type) {
    selectedFuelType.value = type;
  }

  void setRegistrationDate(DateTime date) {
    registrationDate.value = date;
  }

  void setExpiryDate(DateTime date) {
    expiryDate.value = date;
  }

  // ================= Validation =================
  String? validateRequired(String? value, {String field = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  String? validateYear(String? value) {
    if (value == null || value.trim().isEmpty) return 'Year is required';
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Enter a valid year (e.g. 2022)';
    }
    return null;
  }

  String? validateMinLength(String? value,
      {int min = 5, String field = "Field"}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    if (value.length < min) return '$field must be at least $min characters';
    return null;
  }
Future<void> submitVehicleRegistration() async {
  if (selectedVehicleType.value.isEmpty) {
    Get.snackbar("Validation", "Please select a vehicle type");
    return;
  }
  if (selectedFuelType.value.isEmpty) {
    Get.snackbar("Validation", "Please select a fuel type");
    return;
  }
  if (registrationDate.value == null) {
    Get.snackbar("Validation", "Please select registration date");
    return;
  }
  if (expiryDate.value == null) {
    Get.snackbar("Validation", "Please select expiry date");
    return;
  }

  if (!formKey.currentState!.validate()) return;

  isLoading.value = true;

  try {
    final vehicle = VehicleModel(
      vehicleType: selectedVehicleType.value,
      registrationNumber: drivingLicenseController.text,
      make: makeController.text,
      model: modelController.text,
      year: yearController.text,
      color: colorController.text,
      fuelType: selectedFuelType.value,
      ownerName: ownernameController.text,
      ownerAddress: ownerAddressController.text,
      engineNumber: engineNumberController.text,
      chassisNumber: chassisNumberController.text,
      registrationDate: registrationDate.value?.toIso8601String(),
      expiryDate: expiryDate.value?.toIso8601String(),
    );

    final response = await _apiService.registerVehicle(vehicle.toJson());

    if (response.body["success"] == true) {
      Get.snackbar('✅ Success', response.body["message"]);
      Get.toNamed(AppRoutes.documentReview);
    } else {
      // if backend sent validation errors
      if (response.body["errors"] != null &&
          response.body["errors"] is Map<String, dynamic>) {
        final errors = (response.body["errors"] as Map<String, dynamic>)
            .values
            .expand((v) => v)
            .join("\n");
        Get.snackbar('Validation Error', errors);
      } else {
        Get.snackbar('❌ Error', response.body["message"]);
      }
    }
  } catch (e) {
    Get.snackbar('❌ Error', 'Unexpected error occurred');
  } finally {
    isLoading.value = false;
  }
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
    ownernameController.dispose();
    super.onClose();
  }
}
