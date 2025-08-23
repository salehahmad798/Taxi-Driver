import 'package:get/get.dart';
import 'package:taxi_driver/core/controllers/auth_controller.dart';
import 'package:taxi_driver/data/services/api_client.dart';
import 'package:taxi_driver/data/services/api_service.dart';
import 'package:taxi_driver/data/services/history_service.dart';
import 'package:taxi_driver/data/services/notification_service.dart';
import 'package:taxi_driver/data/services/review_service.dart';
import 'package:taxi_driver/data/services/sos_service.dart';
import 'package:taxi_driver/data/services/storage_service.dart';
import 'package:taxi_driver/data/services/wallet_service.dart';
import 'package:taxi_driver/features/driver/authentication/login/login_controller.dart';
import 'package:taxi_driver/features/driver/authentication/otp/otp_controller.dart';
import 'package:taxi_driver/features/driver/authentication/signup/signup_controller.dart';
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    /// StorageService (already initialized in main)
    Get.put<StorageService>(StorageService.instance);

    /// ApiClient depends on StorageService
    Get.lazyPut<ApiClient>(() => ApiClient(Get.find<StorageService>()));

    /// Services
// Get.lazyPut<ApiService>(() => ApiService(Get.find<ApiClient>(), Get.find<StorageService>()));

    Get.lazyPut<ApiService>(() => ApiService(Get.find<ApiClient>()));
    Get.lazyPut<WalletService>(() => WalletService(Get.find<ApiClient>()));
    Get.lazyPut<NotificationService>(() => NotificationService(Get.find<ApiClient>()));
    Get.lazyPut<HistoryService>(() => HistoryService(Get.find<ApiClient>()));
    Get.lazyPut<ReviewService>(() => ReviewService(Get.find<ApiClient>()));
    Get.lazyPut<SosService>(() => SosService(Get.find<ApiClient>()));

    /// Controllers
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<LoginController>(() => LoginController(Get.find<ApiService>()));
    Get.lazyPut<OtpController>(() => OtpController(Get.find<ApiService>(), Get.find<StorageService>()));
  }
}
