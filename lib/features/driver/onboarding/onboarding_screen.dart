import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_driver/core/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        controller.images[index],
                        // height: 134,
                        width: double.infinity,
                      ),
                      SizedBox(height: 20),
                      CText(
                        text: controller.title[index],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primarybackColor,
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CText(
                          maxLines: 2,
                          alignText: TextAlign.center,
                          text: controller.subtext[index],
                          color: AppColors.headingcolor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.images.length,
                (i) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: controller.currentPage.value == i
                      ? 40
                      : 8, 
                  height: controller.currentPage.value == i
                      ? 12
                      : 8, 
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: controller.currentPage.value == i
                        ? AppColors
                              .greyColor 
                        : AppColors.grey.withOpacity(
                            0.5,
                          ), 
                    borderRadius: BorderRadius.circular(
                      20,
                    ), 
                  ),
                ),
              ),
            );
          }),

          SizedBox(height: 30),

          /// "Get Started" Button – shown on all pages
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: PrimaryButton(
              text: 'Get Started',
              tcolor: AppColors.kwhite,
              onTap: controller.goToSignup,
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
