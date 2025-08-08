// verification_screen.dart
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/app_routes.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  late TapGestureRecognizer _resendTapRecognizer;

  @override
  void initState() {
    super.initState();
    _resendTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        print("Resend tapped");
      };
  }

  @override
  void dispose() {
    otpController.dispose();
    _resendTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryappcolor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  text: 'Enter verification code',
                  fontSize: 21.sp,
                  color: AppColors.primarybackColor,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),

            SizedBox(height: 6.h),
            CText(
              text: 'A code has been sent to +91 4545454710',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              maxLines: 2,
            ),

            SizedBox(height: 20.h),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PinCodeTextField(
                appContext: context,
                controller: otpController,
                length: 4,
                keyboardType: TextInputType.number,
                obscureText: false,
                autoFocus: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  inactiveColor: Colors.grey,
                  activeColor: AppColors.kprimaryColor,
                  selectedColor: AppColors.kprimaryColor,
                  inactiveFillColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  borderWidth: 1.5,
                ),
                enableActiveFill: true,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Verify Now',
              onTap: () {
                Get.toNamed(AppRoutes.documentUpload);
              },
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                text: 'Didn’t receive a code? ',
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {
                        log('go to resend');
                        // Get.toNamed(AppRoutes.signIn);
                      },
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          color: AppColors.kprimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
