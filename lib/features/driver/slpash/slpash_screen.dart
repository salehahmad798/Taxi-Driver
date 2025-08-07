import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/constants/app_images.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';
import 'package:taxi_driver/features/driver/slpash/slpash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: AppColors.kprimaryColor,
      body: Center(
        child: ScaleTransition(
          scale: controller.animationController.drive(
            CurveTween(curve: Curves.easeIn),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.appLogo,
                width: 120.w,
                height: 100.w,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.h),
              CText(
                text: 'TAXI APP',
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.kwhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}