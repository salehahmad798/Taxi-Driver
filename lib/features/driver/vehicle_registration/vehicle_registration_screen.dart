import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/vehicle_registration/vehicle_registration_controller.dart';

class VehicleRegistrationView extends GetView<VehicleRegistrationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Vehicle Registration',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Driving License'),
              SizedBox(height: 10),
              _buildTextFormField(
                controller: controller.drivingLicenseController,
                hint: 'Enter driving license number',
                validator: controller.validateRequired,
              ),
              
              SizedBox(height: 20),
              _buildSectionHeader('Vehicle Type'),
              SizedBox(height: 10),
              Obx(() => _buildDropdown(
                value: controller.selectedVehicleType.value.isEmpty 
                    ? null : controller.selectedVehicleType.value,
                items: controller.vehicleTypes,
                hint: 'Select vehicle type',
                onChanged: controller.setVehicleType,
              )),
              
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Make'),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          controller: controller.makeController,
                          hint: 'Toyota',
                          validator: controller.validateRequired,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Model'),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          controller: controller.modelController,
                          hint: 'Corolla',
                          validator: controller.validateRequired,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Year'),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          controller: controller.yearController,
                          hint: '2020',
                          validator: controller.validateRequired,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Color'),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          controller: controller.colorController,
                          hint: 'White',
                          validator: controller.validateRequired,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              _buildSectionHeader('Fuel Type'),
              SizedBox(height: 10),
              Obx(() => _buildDropdown(
                value: controller.selectedFuelType.value.isEmpty 
                    ? null : controller.selectedFuelType.value,
                items: controller.fuelTypes,
                hint: 'Select fuel type',
                onChanged: controller.setFuelType,
              )),
              
              SizedBox(height: 20),
              _buildSectionHeader('Engine Number'),
              SizedBox(height: 10),
              _buildTextFormField(
                controller: controller.engineNumberController,
                hint: 'Enter engine number',
                validator: controller.validateRequired,
              ),
              
              SizedBox(height: 20),
              _buildSectionHeader('Chassis Number'),
              SizedBox(height: 10),
              _buildTextFormField(
                controller: controller.chassisNumberController,
                hint: 'Enter chassis number',
                validator: controller.validateRequired,
              ),
              
              SizedBox(height: 30),
              Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value 
                      ? null 
                      : controller.submitVehicleRegistration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDC143C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFDC143C)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildDropdown({
    String? value,
    required List<String> items,
    required String hint,
    required Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFDC143C)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      hint: Text(hint, style: TextStyle(color: Colors.grey[400])),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }
}
