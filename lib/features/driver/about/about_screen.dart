// lib/app/views/about_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_appbar.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: CustomAppBar(text: 'About'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(text: 'About App', fontSize: 20.sp, fontWeight: FontWeight.bold),
            SizedBox(height: 12.h),
            Text(
              'This app is designed to make your rides safer, easier, and more enjoyable. '
              'We connect passengers and drivers seamlessly, offering a smooth booking experience. '
              'Our goal is to provide high-quality transportation services with transparency and trust.',
              style: TextStyle(fontSize: 16.sp, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
