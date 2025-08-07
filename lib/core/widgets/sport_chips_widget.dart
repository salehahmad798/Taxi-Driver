import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_driver/core/constants/app_images.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';
class SportCategory {
  final String title;
  final String iconPath;
  final Color iconColor;

  SportCategory({
    required this.title,
    required this.iconPath,
    required this.iconColor,
  });
}
class SportChipsWidget {
  int selectedIndex = 0;

  final List<SportCategory> categories = [
    SportCategory(title: "Tennis", iconPath: AppImages.tennisBall, iconColor: Colors.black),
    SportCategory(title: "Volleyball", iconPath: AppImages.tennisBall, iconColor: Colors.red),
    SportCategory(title: "Cricket", iconPath: AppImages.tennisBall, iconColor: Colors.brown),
    SportCategory(title: "Horse Riding", iconPath: AppImages.horseRiding, iconColor: Colors.brown),

    SportCategory(title: "Handball", iconPath: AppImages.tennisBall, iconColor: Colors.orange),
    SportCategory(title: "Cricket", iconPath: AppImages.cricketIcon, iconColor: Colors.brown),
    SportCategory(title: "Horse Riding", iconPath: AppImages.horseRiding, iconColor: Colors.brown),
  ];

  void setSelectedIndex(int index) {
    selectedIndex = index;
  }

  Widget buildChip(SportCategory category, bool isSelected) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 82.w,
        height: 75.w,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              category.iconPath,
              color: category.iconColor,
              height: 24,
              width: 24,
            ),
            SizedBox(height: 8),
            CText(
              text: category.title,
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 14.sp,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
