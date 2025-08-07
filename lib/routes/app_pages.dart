import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:taxi_driver/features/driver/allow_location/allow_location_binding.dart';
import 'package:taxi_driver/features/driver/allow_location/allow_location_screen.dart';
import 'package:taxi_driver/features/driver/authentication/login/login_binding.dart';
import 'package:taxi_driver/features/driver/authentication/login/login_screen.dart';
import 'package:taxi_driver/features/driver/authentication/otp/otp_binding.dart';
import 'package:taxi_driver/features/driver/authentication/otp/otp_screen.dart';
import 'package:taxi_driver/features/driver/authentication/signup/signup_binding.dart';
import 'package:taxi_driver/features/driver/authentication/signup/signup_screen.dart';
import 'package:taxi_driver/features/driver/availability/availability_binding.dart';
import 'package:taxi_driver/features/driver/availability/availability_screen.dart';
import 'package:taxi_driver/features/driver/break_mode/break_mode_binding.dart';
import 'package:taxi_driver/features/driver/break_mode/break_mode_screen.dart';
import 'package:taxi_driver/features/driver/document_review/document_review_binding.dart';
import 'package:taxi_driver/features/driver/document_review/document_review_screen.dart';
import 'package:taxi_driver/features/driver/document_upload/document_upload_binding.dart';
import 'package:taxi_driver/features/driver/document_upload/document_upload_screen.dart';
import 'package:taxi_driver/features/driver/driver_availability/driver_availability_binding.dart';
import 'package:taxi_driver/features/driver/driver_availability/driver_availability_screen.dart';
import 'package:taxi_driver/features/driver/earnings_history/earnings_history_binding.dart';
import 'package:taxi_driver/features/driver/earnings_history/earnings_history_screen.dart';
import 'package:taxi_driver/features/driver/onboarding/onboarding_binding.dart';
import 'package:taxi_driver/features/driver/onboarding/onboarding_screen.dart';
import 'package:taxi_driver/features/driver/slpash/slpash_binding.dart';
import 'package:taxi_driver/features/driver/slpash/slpash_screen.dart';
import 'package:taxi_driver/features/driver/vehicle_details/vehicle_details_binding.dart';
import 'package:taxi_driver/features/driver/vehicle_details/vehicle_details_screen.dart';
import 'package:taxi_driver/features/driver/vehicle_registration/vehicle_registration_binding.dart';
import 'package:taxi_driver/features/driver/vehicle_registration/vehicle_registration_screen.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class AppPages {
  static final initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    // ================= driver flow ==============
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    ),

    // ======== allow location ==========
    GetPage(
      name: AppRoutes.allowLocation,
      page: () => AllowLocationScreen(),
      binding: AllowLocationBinding(),
    ),
    // ========== driver login ======
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),

    // ========== driver otp ======
    GetPage(
      name: AppRoutes.otp,
      page: () => OtpScreen(),
      binding: OtpBinding(),
    ),

    // ========== driver signup ======
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupScreen(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: AppRoutes.vehicleRegistration,
      page: () => VehicleRegistrationView(),
      binding: VehicleRegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.documentUpload,
      page: () => DocumentUploadView(),
      binding: DocumentUploadBinding(),
    ),
    GetPage(
      name: AppRoutes.vehicleDetails,
      page: () => VehicleDetailsView(),
      binding: VehicleDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.documentReview,
      page: () => DocumentReviewView(),
      binding: DocumentReviewBinding(),
    ),
    GetPage(
      name:AppRoutes.availabilityMain,
      page: () => const AvailabilityMainView(),
      binding: AvailabilityMainBinding(),
    ),
    GetPage(
      name: driverAvailability,
      page: () => const DriverAvailabilityView(),
      binding: DriverAvailabilityBinding(),
    ),
    GetPage(
      name:AppRoutes.breakMode,
      page: () => const BreakModeView(),
      binding: BreakModeBinding(),
    ),
    GetPage(
      name: AppRoutes.earningsHistory,
      page: () => const EarningsHistoryView(),
      binding: EarningsHistoryBinding(),
    ),
  ];
  
  static get driverAvailability => null;
}
