import 'package:flutter/material.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor:AppColors.kbackgroundColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.kbackgroundColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.kprimaryColor,
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.kprimaryColor,
      onPrimary: Colors.white,
      secondary: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.kbackgroundColor.withOpacity(0.7),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kbackgroundColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor:AppColors.kprimaryColor,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary:AppColors.kprimaryColor,
      onPrimary: Colors.white,
      secondary: Colors.black,
    ),
  );
}
