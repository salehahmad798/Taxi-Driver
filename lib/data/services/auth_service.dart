// import 'package:taxi_driver/core/constants/network_constants.dart';
// import 'package:taxi_driver/core/utils/app_toast.dart';
// import 'package:taxi_driver/data/models/api_response.dart';
// import 'package:taxi_driver/data/models/auth_models.dart';
// import 'package:taxi_driver/data/services/api_client.dart';
// import 'package:taxi_driver/data/services/storage_service.dart';

// class AuthService {
//   final ApiClient _api;
//   final StorageService _storage;

//   AuthService(this._api, this._storage);

//   Future<ApiResponse<AuthResponse>> loginDriver({
//     required String identifier,
//   }) async {
//     try {
//       final res = await _api.post(NetworkConstants.loginDriver,
//           auth: false, body: {"phone": identifier});

//       final success = (res['success'] ?? true) == true;
//       if (success) {
//         if (res['data']?['token'] != null) {
//           await _storage.saveToken(res['data']['token']);
//         }
//         if (res['data']?['refresh_token'] != null) {
//           await _storage.saveRefreshToken(res['data']['refresh_token']);
//         }
//         AppToast.successToast(res['message'] ?? 'Login successful ✅');
//       } else {
//         AppToast.failToast(res['message'] ?? 'Login failed ❌');
//       }

//       return ApiResponse<AuthResponse>(
//         success: success,
//         message: res['message'],
//         data: success && res['data'] != null
//             ? AuthResponse.fromJson(res['data'])
//             : null,
//       );
//     } catch (e) {
//       AppToast.failToast('Network error occurred');
//       return ApiResponse<AuthResponse>(
//         success: false,
//         message: 'Network error occurred',
//       );
//     }
//   }

//   Future<ApiResponse<AuthResponse>> verifyOtp({
//     required String phone,
//     required String otp,
//   }) async {
//     final res = await _api.post(NetworkConstants.otpVerify,
//         auth: false, body: {"phone": phone, "otp": otp});
//     final success = (res['success'] ?? false) == true;

//     return ApiResponse<AuthResponse>(
//       success: success,
//       message: res['message'],
//       data:
//           success && res['data'] != null ? AuthResponse.fromJson(res['data']) : null,
//     );
//   }

//   Future<ApiResponse<void>> logoutDriver() async {
//     await _storage.clear(); // ✅ always clear locally
//     final res = await _api.post(NetworkConstants.logoutDriver, body: {});
//     return ApiResponse<void>(
//       success: (res['success'] ?? true) == true,
//       message: res['message'] ?? 'Logged out',
//     );
//   }

//   String? getToken() => _storage.getToken();
//   bool isLoggedIn() => getToken() != null;
// }
