

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_driver/core/constants/app_themes.dart';
import 'package:taxi_driver/core/constants/theme_controller.dart';
import 'package:taxi_driver/features/driver/data/services/notification_service.dart';
import 'package:taxi_driver/features/driver/data/services/service_init.dart';
import 'package:taxi_driver/routes/app_pages.dart';
import 'package:taxi_driver/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  



WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage
  await GetStorage.init();
  
  // Initialize Notifications
  // await NotificationService.init();
  
  // Initialize Services
  ServiceInit.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     final ThemeController themeController = Get.put(ThemeController());
  
    return ScreenUtilInit(
      designSize: const Size(393, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      
      builder: (_, child) {
        return GetMaterialApp(
           theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          // theme: AppTheme.lightTheme,  
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.routes,
        );
      },
    );
  }
}