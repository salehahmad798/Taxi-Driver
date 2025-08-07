import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:taxi_driver/core/widgets/custom_textfield.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custom_phone_textfield.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/app_routes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 160.h),

            CText(
              text: 'Sign Up',
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 15.h),
             /// Email Field
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Full Name',
              keyboardType: TextInputType.text,
              textcolor: AppColors.primaryappcolor,
            ),

            /// Password Field
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            
              textcolor: AppColors.primaryappcolor,
            ),
            /// Phone Field
            PhonePickerField(
              width: double.infinity,
              controller: TextEditingController(),
              hintText: 'Phone Number',
            ),
         

           
            // SizedBox(height: 10.h),

            SizedBox(height: 30.h),

            PrimaryButton(
              text: 'Sign Up',
              onTap: () {
                Get.toNamed(AppRoutes.otp);
              },
              width: double.infinity,
            ),
            Spacer(),
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
                      // decoration: TextDecoration.underline,
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
    );
  }
}
