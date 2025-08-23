// ignore_for_file: avoid_print

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

  // Helper method to convert vehicle type string to integer
  int _getVehicleTypeId(String vehicleType) {
    switch (vehicleType.toLowerCase()) {
      case 'car':
        return 1;
      case 'bike':
        return 2;
      case 'truck':
        return 3;
      case 'bus':
        return 4;
      case 'van':
        return 5;
      case 'other':
        return 6;
      default:
        return 1; // Default to car
    }
  }

  // Helper method to convert fuel type string to integer
  int _getFuelTypeId(String fuelType) {
    switch (fuelType.toLowerCase()) {
      case 'petrol':
        return 1;
      case 'diesel':
        return 2;
      case 'electric':
        return 3;
      case 'hybrid':
        return 4;
      case 'cng':
        return 5;
      case 'lpg':
        return 6;
      default:
        return 1; // Default to petrol
    }
  }

  // ================= Validation =================
  String? validateRequired(String? value, {String field = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  String? validateYear(String? value) {
    return validateYearRange(value);
  }

  String? validateMinLength(String? value,
      {int min = 5, String field = "Field"}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    if (value.length < min) return '$field must be at least $min characters';
    return null;
  }

  // Enhanced validation for dates
  String? validateDates() {
    if (registrationDate.value == null) {
      return "Registration date is required";
    }
    if (expiryDate.value == null) {
      return "Expiry date is required";
    }
    
    // Check if expiry date is after registration date
    if (expiryDate.value!.isBefore(registrationDate.value!)) {
      return "Expiry date must be after registration date";
    }
    
    // Check if registration date is not in future
    if (registrationDate.value!.isAfter(DateTime.now())) {
      return "Registration date cannot be in the future";
    }
    
    return null;
  }

  // Validate year range
  String? validateYearRange(String? value) {
    if (value == null || value.trim().isEmpty) return 'Year is required';
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Enter a valid year (e.g. 2022)';
    }
    final year = int.parse(value);
    final currentYear = DateTime.now().year;
    
    if (year < 1900) {
      return 'Year must be after 1900';
    }
    if (year > currentYear + 1) {
      return 'Year cannot be more than ${currentYear + 1}';
    }
    
    return null;
  }

  Future<void> submitVehicleRegistration() async {
    print("=== VEHICLE REGISTRATION SUBMISSION STARTED ===");
    
    // Enhanced validation with detailed logging
    List<String> validationErrors = [];
    
    // Check vehicle type selection
    if (selectedVehicleType.value.isEmpty) {
      validationErrors.add("Vehicle type is required");
      print("❌ Validation Error: Vehicle type not selected");
    } else {
      print("✅ Vehicle Type: ${selectedVehicleType.value} (ID: ${_getVehicleTypeId(selectedVehicleType.value)})");
    }
    
    // Check fuel type selection
    if (selectedFuelType.value.isEmpty) {
      validationErrors.add("Fuel type is required");
      print("❌ Validation Error: Fuel type not selected");
    } else {
      print("✅ Fuel Type: ${selectedFuelType.value} (ID: ${_getFuelTypeId(selectedFuelType.value)})");
    }
    
    // // Validate dates with detailed checks
    // String? dateValidation = validateDates();
    // if (dateValidation != null) {
    //   validationErrors.add(dateValidation);
    //   print("❌ Date Validation Error: $dateValidation");
    // } else {
    //   print("✅ Registration Date: ${registrationDate.value}");
    //   print("✅ Expiry Date: ${expiryDate.value}");
    // }
    
    // Show validation errors if any
    if (validationErrors.isNotEmpty) {
      final errorMessage = validationErrors.join("\n");
      Get.snackbar("Validation Error", errorMessage,
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red[100]);
      print("VALIDATION FAILED: $validationErrors");
      return;
    }
    
    // Validate form fields
    if (!formKey.currentState!.validate()) {
      print("Form validation failed");
      return;
    }
    
    print("All validations passed, proceeding with submission...");
    isLoading.value = true;

    try {
      // Create JSON data with converted integer values and correct field names
      final vehicleData = {
        'vehicle_type': _getVehicleTypeId(selectedVehicleType.value),
        'registration_number': drivingLicenseController.text.trim(),
        'vehicle_make': makeController.text.trim(),  
        'vehicle_model': modelController.text.trim(), 
        'vehicle_year': yearController.text.trim(),   
        'vehicle_color': colorController.text.trim(), 
        'fuel_type': _getFuelTypeId(selectedFuelType.value),
        'owner_name': ownernameController.text.trim(),
        'owner_address': ownerAddressController.text.trim(),
        'engine_number': engineNumberController.text.trim(),
        'chassis_number': chassisNumberController.text.trim(),
        'registration_date': registrationDate.value?.toIso8601String(),
        'expiry_date': expiryDate.value?.toIso8601String(),
      };

      // Log the data being sent
      print("SENDING DATA TO API:");
      print("Vehicle Type ID: ${vehicleData['vehicle_type']}");
      print("Registration Number: ${vehicleData['registration_number']}");
      print("Vehicle Make: ${vehicleData['vehicle_make']}");
      print("Vehicle Model: ${vehicleData['vehicle_model']}");
      print("Vehicle Year: ${vehicleData['vehicle_year']}");
      print("Vehicle Color: ${vehicleData['vehicle_color']}");
      print("Fuel Type ID: ${vehicleData['fuel_type']}");
      print("Owner Name: ${vehicleData['owner_name']}");
      print("Owner Address: ${vehicleData['owner_address']}");
      print("Engine Number: ${vehicleData['engine_number']}");
      print("Chassis Number: ${vehicleData['chassis_number']}");
      print("Registration Date: ${vehicleData['registration_date']}");
      print("Expiry Date: ${vehicleData['expiry_date']}");
      print("Complete JSON: $vehicleData");

      print("Making API call to register vehicle...");
      final response = await _apiService.registerVehicle(vehicleData);

      print("API Response received:");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.body["success"] == true) {
        print("SUCCESS: Vehicle registered successfully!");
        print("Success Message: ${response.body["message"]}");
        if (response.body["data"] != null) {
          print("Response Data: ${response.body["data"]}");
        }
        
        Get.snackbar(
          'Success', 
          response.body["message"] ?? "Vehicle registered successfully!",
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
          duration: Duration(seconds: 3),
        );
        
        print("Navigating to document review screen...");
        Get.toNamed(AppRoutes.documentReview);
      } else {
        print("API ERROR: Registration failed");
        print("Error Message: ${response.body["message"]}");
        
        //  ========== Handle backend validation errors ============ 
        if (response.body["errors"] != null &&
            response.body["errors"] is Map<String, dynamic>) {
          final errorMap = response.body["errors"] as Map<String, dynamic>;
          print("Validation Errors from Backend:");
          errorMap.forEach((field, messages) {
            print(" $field: $messages");
          });
          
          final errors = errorMap.values.expand((v) => v).join("\n");
          Get.snackbar(
            'Validation Error', 
            errors,
            backgroundColor: Colors.orange[100],
            colorText: Colors.orange[800],
            duration: Duration(seconds: 5),
          );
        } else {
          Get.snackbar(
            'Error', 
            response.body["message"] ?? "Failed to register vehicle",
            backgroundColor: Colors.red[100],
            colorText: Colors.red[800],
            duration: Duration(seconds: 4),
          );
        }
      }
    } catch (e, stackTrace) {
      print("EXCEPTION OCCURRED:");
      print("Error: $e");
      print("Stack Trace: $stackTrace");
      
      Get.snackbar(
        'Error', 
        'Network error occurred. Please check your connection and try again.',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        duration: Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
      print("Vehicle registration submission completed");
      print("=== VEHICLE REGISTRATION SUBMISSION ENDED ===\n");
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