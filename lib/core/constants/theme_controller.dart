import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(themeMode);
  }

  void setLightTheme() {
    isDarkMode.value = false;
    Get.changeThemeMode(ThemeMode.light);
  }

  void setDarkTheme() {
    isDarkMode.value = true;
    Get.changeThemeMode(ThemeMode.dark);
  }
}
