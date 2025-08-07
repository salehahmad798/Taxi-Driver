
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/constants/app_fonts.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  String text;
  double? height;
  double? width;
  double? textSize;
  double? radius;
  Color? color;
  Color ? bcolor;
  Color ? tcolor;
  Function() onTap;
  bool? iconEnable;

  PrimaryButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.color,
    this.tcolor,
    this.radius,
    this.bcolor,
    this.textSize,
    required this.onTap,
    this.iconEnable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 327.w,
        height: height ?? 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
           
          ],
          color: color ?? AppColors.kprimaryColor,
          border: Border.all(color: bcolor ?? AppColors.kprimaryColor),
          borderRadius: BorderRadius.circular(radius ?? 8.32.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconEnable == false
                ? const SizedBox()
                : const Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_back_outlined,
                        color: AppColors.primarywhiteColor,
                        size: 18,
                      ),
                    ],
                  ),
            CText(
              text: text,
              fontSize: textSize ?? 16.sp,
              fontWeight: FontWeight.w700,
              color:tcolor ?? AppColors.primarywhiteColor,
            ),
            
          ],
        ),
      ),
    );
  }
}



// ignore: must_be_immutable
class PrimaryIconButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final IconData icon;
  final bool? iconEnable;
  final double? height;
  final double? width;
  final double? textSize;
  final double? radius;
  final Color? color;
  final Color? tcolor;
  final Color? iconColor;

  const PrimaryIconButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon,
    this.iconEnable = false,
    this.height,
    this.width,
    this.color,
    this.tcolor,
    this.radius,
    this.textSize,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 327.w,
        height: height ?? 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.kwhite,
          border: Border.all(color: AppColors.kformborderColor),
          borderRadius: BorderRadius.circular(radius ?? 8.32.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CText(
              text: text,
              fontSize: textSize ?? 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.fontFamily,
              color: tcolor ?? AppColors.kgrableColor4,
            ),
            if (iconEnable == true) ...[
              const SizedBox(width: 5),
              Icon(
                icon,
                color: iconColor ?? AppColors.kgrableColor4,
                size: 22,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PrimaryButton3 extends StatelessWidget {
  String text;
  Function() onTap;
  bool? iconEnable;
  PrimaryButton3({
    super.key,
    required this.text,
    required this.onTap,
    this.iconEnable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 190.w,
        height: 46.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid, width: 1.19),
          // color: AppColors.primarybackColor,
          borderRadius: BorderRadius.circular(
            8.r,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CText(
              text: text,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.headingcolor,
            ),
            iconEnable == false
                ? const SizedBox()
                : const Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primarywhiteColor,
                        size: 18,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class IntroButton extends StatelessWidget {
  Function() onPressed;

  IntroButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 100.w, top: 35.h),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            CText(
              text: 'Next',
              fontSize: 16,
              color: AppColors.primarywhiteColor,
            ),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.primarywhiteColor,
            )
          ],
        ),
      ),
    );
  }
}



// ignore: must_be_immutable
class PrimaryButtonOutlined extends StatelessWidget {
  String text;
  double? height;
  double? width;
  double? textSize;
  double? radius;
  Color? color;
  Color? tcolor;
  Function() onTap;
  bool? iconEnable;

  PrimaryButtonOutlined({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.color,
    this.radius,
    this.tcolor,
    this.textSize,
    required this.onTap,
    this.iconEnable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 327.w,
        height: height ?? 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.5),
                  // blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(
                    0,
                    2,
                  ))
            ],
            color: color ?? AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(radius ?? 6),
            border: Border.all(color: AppColors.primaryappcolor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CText(
              text: text,
              fontSize: textSize ?? 15.sp,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.fontFamily,
              color: tcolor ?? AppColors.primarywhiteColor,
            ),
            iconEnable == false
                ? const SizedBox()
                : const Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primarywhiteColor,
                        size: 18,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}