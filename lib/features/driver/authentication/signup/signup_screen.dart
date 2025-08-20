// signup_screen.dart
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/widgets/custom_phone_textfield.dart';
import 'package:taxi_driver/features/driver/authentication/signup/signup_controller.dart';
import 'package:taxi_driver/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/custom_text.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              CText(
                text: 'Sign Up',
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 15.h),

              /// First Name Field
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: signupController.firstName,
                      hintText: 'First Name',
                      keyboardType: TextInputType.text,
                      textcolor: AppColors.primaryappcolor,
                    ),
                    if (signupController.firstNameError.value != null)
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          signupController.firstNameError.value!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              /// Last Name Field
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: signupController.lastName,
                      hintText: 'Last Name',
                      keyboardType: TextInputType.text,
                      textcolor: AppColors.primaryappcolor,
                    ),
                    if (signupController.lastNameError.value != null)
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          signupController.lastNameError.value!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              /// Email Field
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: signupController.email,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textcolor: AppColors.primaryappcolor,
                    ),
                    if (signupController.emailError.value != null)
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          signupController.emailError.value!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              /// Phone Number Field with PhonePickerField Widget
              PhonePickerField(
                width: double.infinity,
                controller: signupController.phoneNumberController,
                hintText: '(300) 123 4567',
                isoCode: "PK",

                // ✅ pass full number into controller
                onChange: (fullPhone) {
                  signupController.setPhoneNumber(
                    fullPhone,
                    signupController.dialCode,
                  );
                },

                // ✅ keep dial code updated separately
                onDialCodeChanged: (dial) {
                  signupController.dialCode = dial;
                  signupController.fullPhoneNumber =
                      dial + signupController.phoneNumberController.text.trim();
                },
              ),

              Obx(
                () => signupController.phoneError.value != null
                    ? Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          signupController.phoneError.value!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 15.h),

              /// General Error Message
              Obx(
                () => signupController.generalError.value != null
                    ? Container(
                        padding: EdgeInsets.all(10.w),
                        margin: EdgeInsets.only(bottom: 15.h),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error, color: Colors.red, size: 20.sp),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                signupController.generalError.value!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 30.h),

              /// Sign Up Button
              Obx(
                () => PrimaryButton(
                  text: signupController.isLoading.value
                      ? 'Signing up...'
                      : 'Sign Up',
                  onTap: signupController.register,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 20.h),

              /// Sign In Link
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  children: [
                    const TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        color: AppColors.kprimaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoutes.login);
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
