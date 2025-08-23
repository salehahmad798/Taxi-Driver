import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_appbar.dart';
import 'package:taxi_driver/core/widgets/primary_button.dart';
import 'package:taxi_driver/features/driver/vehicle_registration/vehicle_registration_controller.dart';

class VehicleRegistrationScreen extends GetView<VehicleRegistrationController> {
  const VehicleRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(text: 'Vehicle Registration'),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Vehicle Type *'),
              SizedBox(height: 10),
              Obx(() {
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: controller.vehicleTypes.map((type) {
                    bool isSelected =
                        controller.selectedVehicleType.value == type['name'];
                    return GestureDetector(
                      onTap: () =>
                          controller.setVehicleType(type['name'].toString()),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.red[50] : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.kprimaryColor
                                : AppColors.textfieldcolor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              type['icon'] as IconData,
                              color: isSelected
                                  ? AppColors.kprimaryColor
                                  : Colors.grey,
                              size: 30,
                            ),
                            SizedBox(height: 8),
                            Text(
                              type['name'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? AppColors.primaryappcolor
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
              SizedBox(height: 20),

              _buildSectionHeader('Registration Number *'),
              SizedBox(height: 10),
              _buildTextFormField(
                controller: controller.drivingLicenseController,
                hint: 'Enter registration number',
                validator: (v) => controller.validateMinLength(v,
                    min: 5, field: "Registration number"),
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Make *'),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          controller: controller.makeController,
                          hint: 'Toyota',
                          validator: (v) =>
                              controller.validateRequired(v, field: "Make"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Model *'),
                        SizedBox(height: 10.h),
                        _buildTextFormField(
                          controller: controller.modelController,
                          hint: 'Corolla',
                          validator: (v) =>
                              controller.validateRequired(v, field: "Model"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Year *'),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          controller: controller.yearController,
                          hint: '2020',
                          validator: controller.validateYear,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Color *'),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          controller: controller.colorController,
                          hint: 'White',
                          validator: (v) =>
                              controller.validateRequired(v, field: "Color"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              _buildSectionHeader('Fuel Type *'),
              SizedBox(height: 10),
              Obx(() {
                return Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: controller.fuelTypes.map((type) {
                    bool isSelected = controller.selectedFuelType.value == type;
                    return GestureDetector(
                      onTap: () => controller.setFuelType(type),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: 100,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.red[100] : Colors.grey[200],
                          border: Border.all(
                            color:
                                isSelected ? AppColors.backColor : Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            type,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppColors.kprimaryColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),

              SizedBox(height: 20),
              _buildSectionHeader('Owner Name *'),
              SizedBox(height: 10),
              _buildTextFormField(
                controller: controller.ownernameController,
                hint: 'Ahmad',
                validator: (v) =>
                    controller.validateRequired(v, field: "Owner name"),
              ),
              SizedBox(height: 20),

              _buildSectionHeader('Owner Address *'),
              SizedBox(height: 10),
              _buildTextFormField(
                controller: controller.ownerAddressController,
                hint: '123 main street Lahore',
                validator: (v) =>
                    controller.validateRequired(v, field: "Owner address"),
              ),
              SizedBox(height: 20),

              _buildSectionHeader('Engine Number *'),
              SizedBox(height: 10),
              _buildTextFormField(
                controller: controller.engineNumberController,
                hint: 'ENG12345689',
                validator: (v) => controller.validateMinLength(v,
                    min: 6, field: "Engine number"),
              ),

              SizedBox(height: 20),
              _buildSectionHeader('Chassis Number *'),
              SizedBox(height: 10),
              _buildTextFormField(
                controller: controller.chassisNumberController,
                hint: 'CHS54359843543',
                validator: (v) => controller.validateMinLength(v,
                    min: 6, field: "Chassis number"),
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Registration Date *'),
                        SizedBox(height: 10),
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: Get.context!,
                                initialDate: controller.registrationDate.value ??
                                    DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                controller.setRegistrationDate(pickedDate);
                              }
                            },
                            controller: TextEditingController(
                              text: controller.registrationDate.value == null
                                  ? ''
                                  : '${controller.registrationDate.value!.day}/${controller.registrationDate.value!.month}/${controller.registrationDate.value!.year}',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Select registration date',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Expiry Date *'),
                        SizedBox(height: 10),
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: Get.context!,
                                initialDate: controller.expiryDate.value ??
                                    DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                controller.setExpiryDate(pickedDate);
                              }
                            },
                            controller: TextEditingController(
                              text: controller.expiryDate.value == null
                                  ? ''
                                  : '${controller.expiryDate.value!.day}/${controller.expiryDate.value!.month}/${controller.expiryDate.value!.year}',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Select expiry date',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),
              Obx(
                () => PrimaryButton(
                  width: double.infinity,
                  text: controller.isLoading.value ? 'Loading...' : 'Next',
                  onTap: (){
                    // 
                    // controller.submitVehicleRegistration();

                    if(!controller.isLoading.value){
                      controller.submitVehicleRegistration();
                    }

                  }
                ),
              ),
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
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black45,
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
          borderSide: BorderSide(color: AppColors.primaryappcolor),
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
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }

  Widget _buildDateField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.text = "${picked.day}/${picked.month}/${picked.year}";
        }
      },
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }

}


  