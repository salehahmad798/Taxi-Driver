import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_driver/routes/app_routes.dart';
import 'package:get/get.dart';

import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/constants/app_images.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool leadingIcon;

  const CustomAppBar({
    super.key,
    required this.text,
    this.leadingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(120.h),
      child: AppBar(
        backgroundColor: Colors.transparent,
        // shadowColor: Colors.transparent,
        leadingWidth: 40.w,
        leading: leadingIcon
            ? GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  // decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: AppColors.primarywhiteColor),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.kprimaryColor,
                        size: 24.w,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 19.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: const [],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool leadingIcon;
  final bool centerTitle;

  const CustomAppBar2({
    super.key,
    required this.text,
    this.leadingIcon = true,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(120.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 14.w,
          leading: leadingIcon
              ? GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: AppColors.greyColor.withOpacity(0.2),
                    // ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primarybackColor,
                        size: 20.w,
                      ),
                    ),
                  ),
                )
              : null,
          title: Text(
            text,
            style: TextStyle(
              fontSize: 20.sp,
              color: AppColors.primarybackColor,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          centerTitle: centerTitle, 
          elevation: 0,
          actions: const [],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(81.h);
}
class CustomAppBar3 extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final VoidCallback landingIconPressed;
  const CustomAppBar3(
      {super.key, required this.text, required this.landingIconPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.h, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 28.h,
                width: 120.w,
                alignment: Alignment.center,
                child: CText(
                  text: text,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kHeadingColor,
                ),
              ),
              Container(
                height: 24.h,
                width: 24.w,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppImages.appLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              GestureDetector(
                onTap: landingIconPressed,
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kwhite), //boxcolor
                  child: Center(
                      child: SvgPicture.asset(
                    AppImages.appLogo,
                    fit: BoxFit.contain,
                  )),
                ),
              ),
              Positioned(
                  left: 28,
                  child: Container(
                    height: 8.h,
                    width: 8.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.kContainerColor),
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}

class CustomMapAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool leadingIcon;

  const CustomMapAppBar({
    super.key,
    required this.text,
    this.leadingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(120.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 40.w,
          leading: leadingIcon
              ? GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 34.w,
                    height: 34.h,
                    // decoration: BoxDecoration(
                    //   color: AppColors.lightblue,
                    //   shape: BoxShape.circle,
                    //   // borderRadius: BorderRadius.circular(8.r),
                    // ),
                    child: Icon(
                      Icons.arrow_back,
                      size: 22.w,
                      color: AppColors.kprimaryColor,
                    ),
                  ),
                )
              : null,
          title: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            _buildActionButton(Icons.menu),
            SizedBox(width: 10.w),
            // _buildActionButton(Icons.notifications),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColors.kprimaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20.w),
        color: AppColors.kwhite,
        onPressed: () {
          // Get.toNamed(AppRoutes.notification);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}