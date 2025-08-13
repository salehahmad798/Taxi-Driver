import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/features/driver/availability/controller/availability_controller.dart';
import 'package:taxi_driver/features/driver/availability/widget/option_tile_widget.dart';

class AvailabilityMainScreen extends GetView<AvailabilityMainController> {
  const AvailabilityMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Availability & Break System',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Availability & Break System',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
             Text(
              'Manage your driving schedule and take breaks when needed',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            OptionTile(
              icon: Icons.schedule,
              iconColor: Colors.blue,
              title: 'Driver Availability',
              subtitle: 'Set your daily schedule',
              onTap: controller.navigateToDriverAvailability,
            ),
            const SizedBox(height: 16),
            OptionTile(
              icon: Icons.pause_circle_outline,
              iconColor: Colors.orange,
              title: 'Break Mode',
              subtitle: 'Take breaks with auto notification',
              onTap: controller.navigateToBreakMode,
            ),
            const SizedBox(height: 30),
            Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.currentStatus.value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    controller.workingHours.value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }


}
