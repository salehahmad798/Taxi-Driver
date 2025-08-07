



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';

class CustomReviews extends StatelessWidget {
  final String image;
  final String name;
  final String discription;
  const CustomReviews({super.key,required this.image, required this.name, required this.discription});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 52.h, width: 48.w, child: Image.asset(image)),
        SizedBox(
          width: 10.w,
        ),
        SizedBox(
          height: 70.h,
          width: 280.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                text: name,
                fontSize: 12,
                color: AppColors.kHeadingColor,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 50.h,
                width: 279.w,
                child: CText(
                  text:
                      discription,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.ktextColor,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}