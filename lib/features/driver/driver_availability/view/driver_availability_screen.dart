import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_appbar.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';
import 'package:taxi_driver/core/widgets/primary_button.dart';
import 'package:taxi_driver/features/driver/driver_availability/controller/driver_availability_controller.dart';

class DriverAvailabilityScreen extends GetView<DriverAvailabilityController> {
  const DriverAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(text: 'Driver Availability'),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Online Status Section
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.textfieldcolor),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CText(
                                          text: 'Online Status',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primarybackColor,
                                        ),
                                        Text(
                                          'Toggle to go online/offline',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Switch(
                                      value: controller.isOnline.value,
                                      onChanged: (_) => controller.toggleOnlineStatus(),
                                      activeColor: Colors.green,
                                      activeTrackColor: Colors.green.withOpacity(0.4),
                                      inactiveThumbColor: Colors.grey,
                                      inactiveTrackColor: Colors.grey.withOpacity(0.4),
                                      trackOutlineColor: WidgetStateColor.resolveWith(
                                        (states) => controller.isOnline.value
                                            ? Colors.green.withOpacity(0.4)
                                            : Colors.grey.withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: controller.isOnline.value
                                            ? Colors.green
                                            : Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      controller.isOnline.value
                                          ? 'You are online and available for rides'
                                          : 'You are offline',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: controller.isOnline.value
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // Daily Active Hours Section
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.textfieldcolor),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Daily Active Hours',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: controller.toggleBreakMode,
                                    child: Text(
                                      'Break Mode',
                                      style: TextStyle(
                                        color: Colors.blue[600],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => Column(
                                  children: List.generate(
                                    controller.dailySchedules.length,
                                    (index) {
                                      final schedule = controller.dailySchedules[index];
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 16),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  schedule.day,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Switch(
                                                  value: schedule.isActive,
                                                  onChanged: (_) =>
                                                      controller.toggleDaySchedule(index),
                                                  activeColor: Colors.blue,
                                                  activeTrackColor: Colors.blue.withOpacity(0.4),
                                                  inactiveThumbColor: Colors.white,
                                                  inactiveTrackColor: Colors.grey.withOpacity(0.4),
                                                  trackOutlineColor:
                                                      WidgetStateColor.resolveWith(
                                                    (states) => controller.isOnline.value
                                                        ? Colors.white
                                                        : Colors.grey.withOpacity(0.4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (schedule.isActive) ...[
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildTimePicker(
                                                      context,
                                                      index,
                                                      true,
                                                      schedule.startTime,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: _buildTimePicker(
                                                      context,
                                                      index,
                                                      false,
                                                      schedule.endTime,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // Quick Actions
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.textfieldcolor),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Quick Actions',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: controller.enableAllDays,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.withOpacity(0.08),
                                        foregroundColor: Colors.blue,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      child: const Text(
                                        'Enable All Days',
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: controller.disableAllDays,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.withOpacity(0.08),
                                        foregroundColor: Colors.grey[800],
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      child: const Text(
                                        'Disable All Days',
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        PrimaryButton(
                          text: 'Save Schedule',
                          width: double.infinity,
                          onTap: controller.saveSchedule,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimePicker(
      BuildContext context, int index, bool isStartTime, TimeOfDay time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isStartTime ? 'Start Time' : 'End Time',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _selectTime(context, index, isStartTime),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.formatTime(time),
                  style: const TextStyle(fontSize: 14),
                ),
                const Icon(Icons.access_time, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(
    BuildContext context,
    int index,
    bool isStartTime,
  ) async {
    final schedule = controller.dailySchedules[index];
    final currentTime = isStartTime ? schedule.startTime : schedule.endTime;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (picked != null) {
      if (isStartTime) {
        controller.updateStartTime(index, picked);
      } else {
        controller.updateEndTime(index, picked);
      }
    }
  }
}
