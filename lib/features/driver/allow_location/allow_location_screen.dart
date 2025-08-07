import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/primary_button.dart';
import 'allow_location_controller.dart';

class AllowLocationScreen extends StatelessWidget {
  AllowLocationScreen({super.key});
  final AllowLocationController allowLocationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackGroundColor,
      body: Column(
        children: [
          Image.asset(AppImages.allowLocation, width: double.infinity,),
          CText(
            text: '''Don't worry your data is private''',
            color: AppColors.primarybackColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
          Spacer(),
          PrimaryButton(
            text: 'Allow Location',
            onTap: () {
              allowLocationController.requestLocationPermission(context);
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
