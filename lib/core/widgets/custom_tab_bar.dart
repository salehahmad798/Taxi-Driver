
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taxi_driver/core/constants/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final VoidCallback onFavoritePressed;

  const CustomTabBar({
    Key? key,
    required this.tabController,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 20,
          ),
          // Tabs
          Container(
            height: 30.h,
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Details'),
                Tab(text: 'Products'),
              ],
              dividerHeight: 0,
              labelStyle: TextStyle(
                color: AppColors.kindicatorback,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Sen',
              ),
              indicatorWeight: 2,
              indicatorColor: AppColors.kindicator,
              labelColor: AppColors.kindicatorback,
              unselectedLabelColor: AppColors.greyColor,
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          // GestureDetector(
          //     onTap: onFavoritePressed,
          //     child: const CustomIcon(
          //       icon: Icons.favorite_border,
          //     ))
        ],
      ),
    );
  }
}