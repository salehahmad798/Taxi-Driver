import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/primary_button.dart';
import 'otp_controller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController _otpController = Get.find<OtpController>();
  late TapGestureRecognizer _resendTapRecognizer;
  final Map<String, dynamic> args = Get.arguments;
  @override
  void initState() {
    super.initState();
    _resendTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        if (!_otpController.isResendLoading.value) {
          _otpController.resendOtp();
        }
      };
  }

  @override
  void dispose() {
    _resendTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = args["phone_number"] ?? "";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryappcolor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 100.h),

            /// Title
            CText(
              text: 'Enter verification code',
              fontSize: 21.sp,
              color: AppColors.primarybackColor,
              fontWeight: FontWeight.w700,
            ),

            SizedBox(height: 6.h),

            /// Info text
            CText(
              text:
                  'A code has been sent to ${_otpController.phone}', 
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              maxLines: 2,
              alignText: TextAlign.center,
            ),

            SizedBox(height: 20.h),

            /// OTP Input Field + Error
            Obx(
              () => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: PinCodeTextField(
                      appContext: context,
                      controller: _otpController.otpController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8.r),
                        fieldHeight: 50.h,
                        fieldWidth: 50.w,
                        inactiveColor: _otpController.otpError.value != null
                            ? AppColors.kprimaryColor
                            : Colors.grey,
                        activeColor: _otpController.otpError.value != null
                            ? Colors.red
                            : AppColors.kprimaryColor,
                        selectedColor: _otpController.otpError.value != null
                            ? Colors.red
                            : AppColors.kprimaryColor,
                        inactiveFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        borderWidth: 1.5,
                      ),
                      enableActiveFill: true,
                      onChanged: (value) {
                        if (_otpController.otpError.value != null) {
                          _otpController.otpError.value = null;
                        }
                      },
                    ),
                  ),

                  /// Error message
                  if (_otpController.otpError.value != null)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        _otpController.otpError.value!,
                        style: TextStyle(
                          color: AppColors.kprimaryColor,
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            /// Verify Button
            Obx(
              () => PrimaryButton(
                text: _otpController.isOtpLoading.value
                    ? 'Verifying...'
                    : 'Verify Now',
                onTap: () {
                  if (!_otpController.isOtpLoading.value) {
                    _otpController.verifyOtp();
                  }
                },
              ),
            ),

            SizedBox(height: 16.h),

            /// Resend OTP
            Obx(
              () => RichText(
                text: TextSpan(
                  text: 'Didn\'t receive a code? ',
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: _otpController.isResendLoading.value
                          ? 'Sending...'
                          : 'Resend',
                      style: TextStyle(
                        color: _otpController.isResendLoading.value
                            ? Colors.grey
                            : AppColors.kprimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                      recognizer: _resendTapRecognizer,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            /// General Error Message
            Obx(
              () => _otpController.generalError.value != null
                  ? Container(
                      padding: EdgeInsets.all(15.w),
                      margin: EdgeInsets.only(top: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.kprimaryColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: AppColors.kprimaryColor,
                            size: 20.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              _otpController.generalError.value!,
                              style: TextStyle(
                                color: AppColors.kprimaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
