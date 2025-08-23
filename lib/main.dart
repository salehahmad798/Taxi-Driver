import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_driver/core/constants/app_themes.dart';
import 'package:taxi_driver/core/constants/theme_controller.dart';
import 'package:taxi_driver/data/services/storage_service.dart';
import 'package:taxi_driver/data/services/service_init.dart';
import 'package:taxi_driver/initial_binding.dart';
import 'package:taxi_driver/routes/app_pages.dart';
import 'package:taxi_driver/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  // Initialize StorageService FIRST
  await StorageService.init();

  // Initialize other services
  ServiceInit.init();

  runApp(const MyApp());
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
      builder: (_, __) {
        return GetMaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          debugShowCheckedModeBanner: false,
          // initialRoute: AppRoutes.splash,
          initialRoute: AppRoutes.vehicleRegistration,
          initialBinding: InitialBinding(),
          getPages: AppPages.routes,
        );
      },
    );
  }
}
