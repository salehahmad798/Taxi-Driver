import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_appbar.dart';
import 'package:taxi_driver/core/widgets/primary_button.dart';
import 'package:taxi_driver/features/driver/break_mode/break_mode_controller.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class BreakModeScreen extends GetView<BreakModeController> {
  const BreakModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(text: 'Break Mode'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================  Status Section ====================
            Center(
              child: Column(
                children: [
                  Obx(
                    () => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: controller.isOnBreak.value
                            ? Colors.orange[100]
                            : Colors.green[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.isOnBreak.value
                            ? Icons.pause
                            : Icons.play_circle_fill,
                        size: 50,
                        color: controller.isOnBreak.value
                            ? Colors.orange[600]
                            : Colors.green[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Text(
                      controller.isOnBreak.value ? 'On Break' : 'Available',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: controller.isOnBreak.value
                            ? Colors.orange[600]
                            : Colors.green[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      controller.breakStatusText,
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ============== Quick Break Options ===========
            Text(
              'Quick Break Options',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _buildQuickBreakButton('15 mins', 15, Icons.coffee),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickBreakButton(
                    '30 mins',
                    30,
                    Icons.restaurant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildQuickBreakButton('1 hour', 60, Icons.timer),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickBreakButton('2 hours', 120, Icons.schedule),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Custom Duration
            const Text(
              'Custom Duration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.customBreakDuration,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Minutes',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: controller.startCustomBreak,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryappcolor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text('Start'),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              'Enter duration in minutes (1-480 min)',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
            ),

            const SizedBox(height: 40),

            // Recent Break Sessions
            const Text(
              'Recent Break Sessions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Obx(() {
              if (controller.breakSessions.isEmpty) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.history,
                          size: 48.w,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No break sessions yet',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.breakSessions.length,
                itemBuilder: (context, index) {
                  final session = controller.breakSessions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.pause_circle,
                        color: session.isActive
                            ? AppColors.kprimaryColor
                            : Colors.grey,
                      ),
                      title: Text(
                        '${session.duration} minutes break',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'Started: ${_formatDateTime(session.startTime)}',
                      ),
                      trailing: session.isActive
                          ? ElevatedButton(
                              onPressed: controller.endBreak,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.kprimaryColor,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('End'),
                            )
                          : null,
                    ),
                  );
                },
              );
            }),

            const SizedBox(height: 30),

            //=================== Break Mode Tips ===============
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                // border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue[600]),
                      const SizedBox(width: 8),
                      Text(
                        'Break Mode Tips',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTipItem(
                    'You\'ll automatically go online when break time ends',
                  ),
                  _buildTipItem(
                    'Take 15-30 min breaks for meals and short rests',
                  ),
                  _buildTipItem('Use 2+ hour breaks for longer meal breaks'),
                  _buildTipItem('You can end your break early anytime'),
                ],
              ),
            ),
            SizedBox(height: 10),
            PrimaryButton(
              text: 'Earning & History',

              width: double.infinity,
              onTap: () {
                Get.toNamed(AppRoutes.earningsHistory);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickBreakButton(String label, int minutes, IconData icon) {
    return Obx(
      () => InkWell(
        onTap: () => controller.startQuickBreak(minutes),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: controller.selectedQuickBreak.value == minutes
                ? Colors.red[50]
                : Colors.white,
            border: Border.all(
              color: controller.selectedQuickBreak.value == minutes
                  ? Colors.red[300]!
                  : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: controller.selectedQuickBreak.value == minutes
                      ? Colors.red[100]
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: controller.selectedQuickBreak.value == minutes
                      ? Colors.red[600]
                      : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: controller.selectedQuickBreak.value == minutes
                      ? Colors.red[700]
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 8, right: 8),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp, color: Colors.blue[700]),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
