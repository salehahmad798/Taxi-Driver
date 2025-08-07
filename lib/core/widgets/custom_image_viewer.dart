import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taxi_driver/core/constants/app_colors.dart' show AppColors;
import 'package:taxi_driver/core/constants/app_images.dart';
import 'package:taxi_driver/core/widgets/custom_image.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';

class ImageView extends StatelessWidget {
  final String image;
  final int remainingImages;

  ImageView({super.key, required this.image, this.remainingImages = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 114.w,
      height: 95.h,
      decoration: BoxDecoration(
          color: AppColors.darkgrey, borderRadius: BorderRadius.circular(10.r)),
      child: Stack(
        children: [
          CustomNetworkImage(
      imageUrl:       image.isNotEmpty ? image : AppImages.appLogo,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          if (remainingImages > 0)
            GestureDetector(
              onTap: () {
                print('show the all images');
              },
              child: Center(
                child: CText(
                  text: '+$remainingImages',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primarywhiteColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}