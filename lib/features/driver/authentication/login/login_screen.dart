import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:taxi_driver/core/widgets/custom_textfield.dart';
import 'package:taxi_driver/features/driver/authentication/otp/password_otp.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custom_phone_textfield.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            SvgPicture.asset(AppImages.appLogo, color: AppColors.kprimaryColor),
            SizedBox(height: 10.h),
            CText(
              text: 'TAXI APP',
              fontSize: 29.sp,
              color: AppColors.primaryappcolor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            CText(
              text: 'LOGIN',
              fontSize: 30.sp,
              color: AppColors.primarybackColor,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10.h),
            Center(
              child: SizedBox(
                width: Get.width * 0.9,
                child: CText(
                  alignText: TextAlign.center,
                  text: 'Login with your Email or Phone number',
                  fontSize: 18.sp,
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(height: 15.h),

            /// Phone Field
            PhonePickerField(
              width: double.infinity,
              controller: TextEditingController(),
              hintText: 'Phone Number',
            ),
            SizedBox(height: 20.h),

            /// Divider with "Or"
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.greyColor,
                    indent: 20,
                    endIndent: 10,
                    thickness: 1,
                  ),
                ),
                CText(text: 'Or', fontSize: 14.sp),
                Expanded(
                  child: Divider(
                    color: AppColors.greyColor,
                    indent: 10,
                    endIndent: 20,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            /// Email Field
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textcolor: AppColors.primaryappcolor,
            ),
            // SizedBox(height: 10.h),

            /// Password Field
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Password',
              keyboardType: TextInputType.text,
              textcolor: AppColors.primaryappcolor,
            ),

            ///============= Forgot Password==================
            GestureDetector(
              onTap: () {
                Get.to(() => PasswordOtp());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  CText(
                    text: 'Forgot password ?',
                    fontSize: 16.sp,
                    color: AppColors.primarybackColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            PrimaryButton(
              text: 'Log In',
              onTap: () {
                Get.toNamed(AppRoutes.otp);
              },
              width: double.infinity,
            ),
            // SizedBox(height: 15.h),
            Spacer(),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
                children: [
                  const TextSpan(text: "Don’t have an account? "),
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      color: AppColors.kprimaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      // decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(AppRoutes.signup);
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
