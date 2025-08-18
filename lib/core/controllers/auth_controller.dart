import 'package:get/get.dart';
import 'package:taxi_driver/data/services/storage_service.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class AuthController extends GetxController {
  final StorageService _storage = StorageService.instance;
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  void _bootstrap() {
    final token = _storage.getAccessToken();
    isLoggedIn.value = token != null && token.isNotEmpty;

    if (isLoggedIn.value) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> login(String token, String refreshToken) async {
    await _storage.saveAccessToken(token);
    await _storage.saveRefreshToken(refreshToken);
    isLoggedIn.value = true;
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> logout() async {
    await _storage.removeAccessToken();
    await _storage.removeRefreshToken();
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login);
  }

  String? get accessToken => _storage.getAccessToken();
  String? get refreshToken => _storage.getRefreshToken();
}
