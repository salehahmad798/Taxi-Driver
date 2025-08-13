import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_text.dart';
import 'package:taxi_driver/features/driver/sos/sos_controller.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SosScreen extends GetView<SosController> {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.menu_sharp, color: AppColors.primarybackColor)),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Get.height * 0.1),
          const Center(
            child: Text(
              "Are you in emergency?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: Get.width * 0.7,
            child: CText(
              text: 'Press the button below help will reach you soon.',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              maxLines: 2,
              alignText: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(height: Get.height * 0.1),

          GestureDetector(
            onTap: controller.sendSos,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xffDC2626),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Color(0xffEF4444), blurRadius: 50),
                ],
              ),
              child: const Center(
                child: Text(
                  "SOS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.1),

          Obx(
            () => SizedBox(
              width: Get.width * 0.7,
              child: Card(
                shadowColor: AppColors.Kblue,
                color: AppColors.kwhite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Color(0xffDC2626),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Color(0xffEF4444), blurRadius: 50),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "SOS",
                            style: TextStyle(color: Colors.white, fontSize: 6),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      CText(
                        text:
                            "Your current address:\n${controller.currentAddress.value}",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        alignText: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}