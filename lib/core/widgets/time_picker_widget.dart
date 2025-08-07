

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';

import '../constants/theme_controller.dart';

timePiker(context) async {
  ThemeController themeController = Get.put(ThemeController());
  final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {

        if (themeController.isDarkMode.value) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryappcolor,
                onPrimary: Colors.red,
                surface: Colors.red,
                onSurface: Colors.black,
                secondary: AppColors.primarybackColor,
                onSecondary: Colors.blue,
                surfaceContainerHighest: AppColors.primarybackColor.withOpacity(0.3),
              ),
            ),
            child: child!,
          );
        } else {
          return Theme(
            data: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.white,
                onPrimary: Colors.blue,
                surface: AppColors.primarybackColor,
                onSurface: Colors.blue,
                surfaceTint: AppColors.primarybackColor,
                secondary: AppColors.backgroundColor,
                onSecondary: Colors.blue,
                surfaceContainerHighest: Colors.transparent,
              ),
            ),
            child: child!,
          );
        }
      });
  if (newTime != null) {
    // dialogController.updateTime(newTime);
    return newTime;
  }
}
class TimePickerWidget extends StatefulWidget {
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {


  final List<int> hours = List.generate(12, (index) => index + 1);
  final List<int> minutes = List.generate(60, (index) => index);
  final List<String> periods = ['am'.tr, 'pm'.tr];

  @override
  void initState() {
    super.initState();
    
  }



  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}