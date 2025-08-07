
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';

class CustomIcon extends StatelessWidget {
  final height;
  final width;
  final icon;
  final iconColor;
  final bgColor;
  const CustomIcon(
      {super.key,
      required this.icon,
      this.height,
      this.width,
      this.iconColor,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40.h,
      width: width ?? 40.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? AppColors.kwhite), //boxcolor
      child: Center(
          child: Icon(
        icon ?? Icons.favorite_border,
        color: iconColor ?? AppColors.kindicatorback,
      )),
    );
  }
}



class CustomIconText extends StatelessWidget {
  final String image;
  final String text;

  const CustomIconText({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
          fit: BoxFit.cover,
        ),
        CText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.ktextColor,
        ),
      ],
    );
  }
}




class CustomIconTextwithBack extends StatelessWidget {
  final String image;
  final String text;
  final Function() onTap;

  const CustomIconTextwithBack({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16.w,
              height: 16.h,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            CText(
              text: text,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.kHeadingColor,
            ),
          ],
        ),
      ),
    );
  }
}