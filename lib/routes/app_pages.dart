import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:taxi_driver/features/driver/FAQ/FAQ_binding.dart';
import 'package:taxi_driver/features/driver/FAQ/FAQ_screen.dart';
import 'package:taxi_driver/features/driver/about/about_binding.dart';
import 'package:taxi_driver/features/driver/about/about_screen.dart';
import 'package:taxi_driver/features/driver/allow_location/allow_location_binding.dart';
import 'package:taxi_driver/features/driver/allow_location/allow_location_screen.dart';
import 'package:taxi_driver/features/driver/authentication/login/login_binding.dart';
import 'package:taxi_driver/features/driver/authentication/login/login_screen.dart';
import 'package:taxi_driver/features/driver/authentication/otp/otp_binding.dart';
import 'package:taxi_driver/features/driver/authentication/otp/otp_screen.dart';
import 'package:taxi_driver/features/driver/authentication/signup/signup_binding.dart';
import 'package:taxi_driver/features/driver/authentication/signup/signup_screen.dart';
import 'package:taxi_driver/features/driver/availability/binding/availability_binding.dart';
import 'package:taxi_driver/features/driver/availability/view/availability_main_screen.dart';
import 'package:taxi_driver/features/driver/break_mode/break_mode_binding.dart';
import 'package:taxi_driver/features/driver/break_mode/break_mode_screen.dart';
import 'package:taxi_driver/features/driver/chat/binding/chat_binding.dart';
import 'package:taxi_driver/features/driver/chat/view/chat_screen.dart';
import 'package:taxi_driver/features/driver/customer_reviews/customer_reviews_binding.dart';
import 'package:taxi_driver/features/driver/customer_reviews/customer_reviews_screen.dart';
import 'package:taxi_driver/features/driver/document_review/document_review_binding.dart';
import 'package:taxi_driver/features/driver/document_review/document_review_screen.dart';
import 'package:taxi_driver/features/driver/document_upload/document_upload_binding.dart';
import 'package:taxi_driver/features/driver/document_upload/document_upload_screen.dart';
import 'package:taxi_driver/features/driver/driver_availability/binding/driver_availability_binding.dart';
import 'package:taxi_driver/features/driver/driver_availability/view/driver_availability_screen.dart';
import 'package:taxi_driver/features/driver/earnings_history/binding/earnings_history_binding.dart';
import 'package:taxi_driver/features/driver/earnings_history/view/earnings_history_screen.dart';
import 'package:taxi_driver/features/driver/edit_account/edit_account_binding.dart';
import 'package:taxi_driver/features/driver/edit_account/edit_account_screen.dart';
import 'package:taxi_driver/features/driver/history/history_binding.dart';
import 'package:taxi_driver/features/driver/history/history_screen.dart';
import 'package:taxi_driver/features/driver/home/binding/home_binding.dart';
import 'package:taxi_driver/features/driver/home/view/home_screen.dart';
import 'package:taxi_driver/features/driver/my_account/my_account_binding.dart';
import 'package:taxi_driver/features/driver/my_account/my_account_screen.dart';
import 'package:taxi_driver/features/driver/notification/notification_binding.dart';
import 'package:taxi_driver/features/driver/notification/notification_screen.dart';
import 'package:taxi_driver/features/driver/onboarding/onboarding_binding.dart';
import 'package:taxi_driver/features/driver/onboarding/onboarding_screen.dart';
import 'package:taxi_driver/features/driver/pickup/binding/pickup_binding.dart';
import 'package:taxi_driver/features/driver/pickup/view/pickup_screen.dart';
import 'package:taxi_driver/features/driver/slpash/slpash_binding.dart';
import 'package:taxi_driver/features/driver/slpash/slpash_screen.dart';
import 'package:taxi_driver/features/driver/sos/sos_binding.dart';
import 'package:taxi_driver/features/driver/sos/sos_screen.dart';
import 'package:taxi_driver/features/driver/vehicle_details/vehicle_details_binding.dart';
import 'package:taxi_driver/features/driver/vehicle_details/vehicle_details_screen.dart';
import 'package:taxi_driver/features/driver/vehicle_registration/vehicle_registration_binding.dart';
import 'package:taxi_driver/features/driver/vehicle_registration/vehicle_registration_screen.dart';
import 'package:taxi_driver/features/driver/wallet/wallet_binding.dart';
import 'package:taxi_driver/features/driver/wallet/wallet_screen.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

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
      page: () =>  LoginScreen(),
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
      page: () => VehicleRegistrationScreen(),
      binding: VehicleRegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.documentUpload,
      page: () => DocumentUploadScreen(),
      binding: DocumentUploadBinding(),
    ),
    GetPage(
      name: AppRoutes.vehicleDetails,
      page: () => VehicleDetailsScreen(),
      binding: VehicleDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.documentReview,
      page: () => DocumentReviewScreen(),
      binding: DocumentReviewBinding(),
    ),
    GetPage(
      name:AppRoutes.availabilityMain,
      page: () => const AvailabilityMainScreen(),
      binding: AvailabilityMainBinding(),
    ),
    GetPage(
      name:AppRoutes.driverAvailability,
      page: () => const DriverAvailabilityScreen(),
      binding: DriverAvailabilityBinding(),
    ),
    GetPage(
      name:AppRoutes.breakMode,
      page: () => const BreakModeScreen(),
      binding: BreakModeBinding(),
    ),
    GetPage(
      name: AppRoutes.earningsHistory,
      page: () => const EarningsHistoryScreen(),
      binding: EarningsHistoryBinding(),
    ),





GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.pickup,
      page: () => PickupScreen(),
      binding: PickupBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),






// GetPage(
//       name: AppRoutes.HOME,
//       page: () => HomeView(),
//       binding: HomeBinding(),
//     ),
    GetPage(
      name: AppRoutes.myAccount,
      page: () => MyAccountScreen(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.editAccount,
      page: () => EditAccountView(),
      binding: EditAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.wallet,
      page: () => WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => HistoryScreen(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.customerReviews,
      page: () => CustomerReviewsScreen(),
      binding: CustomerReviewsBinding(),
    ),
    GetPage(
      name: AppRoutes.faq,
      page: () => FAQScreen(),
      binding: FAQBinding(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => AboutScreen(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: AppRoutes.sos,
      page: () => SosScreen(),
      binding: SosBinding(),
    ),




  ];
  

}
