import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/authentication/login/login_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custom_phone_textfield.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              SvgPicture.asset(
                AppImages.appLogo,
                color: AppColors.kprimaryColor,
                height: 80.h,
              ),
              SizedBox(height: 15.h),
              CText(
                text: 'TAXI APP',
                fontSize: 28.sp,
                color: AppColors.primaryappcolor,
                fontWeight: FontWeight.w600,
                alignText: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              CText(
                text: 'LOGIN',
                fontSize: 26.sp,
                color: AppColors.primarybackColor,
                fontWeight: FontWeight.w400,
                alignText: TextAlign.center,
              ),
              SizedBox(height: 25.h),
              CText(
                text: 'Login with your Phone number',
                fontSize: 18.sp,
                alignText: TextAlign.center,
              ),
              SizedBox(height: 40.h),

              ///  ========== Phone Field ===========
              PhonePickerField(
                hintText: "phone number",
                width: double.infinity,
                controller: loginController.phone,
                isoCode: "PK",
                onChange: (fullPhone) {
                  print("Full Phone: $fullPhone"); 
                },
                onDialCodeChanged: (dialCode) {
                  print("Dial Code: $dialCode"); 
                },
              ),
              Obx(
                () => loginController.phoneError.value != null
                    ? Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          loginController.phoneError.value!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              SizedBox(height: 20.h),

              /// ========== General Error ==========
              Obx(
                () => loginController.generalError.value != null
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
                                loginController.generalError.value!,
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

              Obx(
                () => PrimaryButton(
                  text: loginController.isLoading.value
                      ? 'Logging in...'
                      : 'Log In',
                  onTap: () {
                    if (!loginController.isLoading.value) {
                      loginController.login();
                    }
                  },
                  width: double.infinity,
                ),
              ),

              SizedBox(height: 20.h),

            
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: AppColors.kprimaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (!loginController.isLoading.value) {
                              Get.toNamed(AppRoutes.signup);
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
