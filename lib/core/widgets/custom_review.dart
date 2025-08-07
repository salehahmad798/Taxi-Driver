
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/constants/app_images.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';

class Review extends StatelessWidget {
  final String reviewerName;
  final String reviewText;
  final int rating;
  final String revieerdp;
  Review(
      {required this.reviewerName,
      required this.reviewText,
      required this.rating,
      required this.revieerdp});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28.w,
        backgroundImage: revieerdp.isNotEmpty
            ? NetworkImage(revieerdp)
            : AssetImage(AppImages.appLogo),
      ),
      title: CText(
        text: reviewerName,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primarybackColor,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: CText(
              text: reviewText,
              fontSize: 12.sp,
              maxLines: 2,
              fontWeight: FontWeight.w500,
              color: AppColors.darkgrey,
            ),
          ),
          Row(
            children: List.generate(5, (starIndex) {
              return Icon(
                Icons.star,
                color: starIndex < 4 ? Colors.orange : Colors.grey,
                size: 16,
              );
            }),
          ),
        ],
      ),
    );
  }
}