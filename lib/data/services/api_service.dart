// // lib/core/services/api_service.dart
// import 'dart:convert';
// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:taxi_driver/data/models/auth_models.dart';

// import '../models/api_response.dart';
// import '../models/user_model.dart';
// import '../models/wallet_model.dart';
// import '../models/notification_model.dart';
// import '../models/history_model.dart';
// import '../models/review_model.dart';
// import 'storage_service.dart';

// class ApiService extends GetxService {
//   static const String baseUrl = 'https://taxiportal.keyteh.site/api';
//   final StorageService _storage = Get.find<StorageService>();

//   // Headers
//   Map<String, String> get headers => {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         // if (_storage.userToken != null)
//         //   'Authorization': 'Bearer ${_storage.userToken}',
//         if (_storage.getToken() != null)
//           'Authorization': 'Bearer ${_storage.getToken()}',
//       };

//   Map<String, String> headersWithAuth(String token) => {
//         ...headers,
//         'Authorization': 'Bearer $token',
//       };

//   // ========================= AUTH SECTION =========================

//   // Driver Registration
//   Future<ApiResponse<AuthResponse>> registerDriver({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String phone,
//     required String password,
//     required double latitude,
//     required double longitude,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/driver/register'),
//         headers: headers,
//         body: jsonEncode({
//           'first_name': firstName,
//           'last_name': lastName,
//           'email': email,
//           'phone': phone,
//           'password': password,
//           'latitude': latitude.toString(),
//           'longitude': longitude.toString(),
//         }),
//       );

//       log('Register Response: ${response.statusCode} - ${response.body}');
//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return ApiResponse<AuthResponse>(
//           success: data['success'] ?? true,
//           message: data['message'] ?? 'Registration successful',
//           data: AuthResponse.fromJson(data['data']),
//           meta: data['meta'] != null ? Meta.fromJson(data['meta']) : null,
//         );
//       } else {
//         return ApiResponse<AuthResponse>(
//           success: false,
//           message: data['message'] ?? 'Registration failed',
//           errors: data['errors'],
//         );
//       }
//     } catch (e) {
//       log('Register Error: $e');
//       return ApiResponse<AuthResponse>(
//         success: false,
//         message: 'Network error occurred',
//       );
//     }
//   }

//   // Driver Login
//   Future<ApiResponse<AuthResponse>> loginDriver({
//     required String identifier,
    
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/driver/login'),
//         headers: headers,
//         body: jsonEncode({
//           'identifier': identifier,
//         }),
//       );

//       log('Login Response: ${response.statusCode} - ${response.body}');
//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         return ApiResponse<AuthResponse>(
//           success: data['success'] ?? true,
//           message: data['message'] ?? 'Login successful',
//           data: AuthResponse.fromJson(data['data']),
//           meta: data['meta'] != null ? Meta.fromJson(data['meta']) : null,
//         );
//       } else {
//         return ApiResponse<AuthResponse>(
//           success: false,
//           message: data['message'] ?? 'Login failed',
//           errors: data['errors'],
//         );
//       }
//     } catch (e) {
//       log('Login Error: $e');
//       return ApiResponse<AuthResponse>(
//         success: false,
//         message: 'Network error occurred',
//       );
//     }
//   }



//   // Verify OTP
//   Future<ApiResponse<AuthResponse>> verifyOtp({
//     required String phone,
//     required String otp,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/driver/otp/verify'),
//         headers: headers,
//         body: jsonEncode({
//           'phone': phone,
//           'otp': otp,
//         }),
//       );

//       log('OTP Verify Response: ${response.statusCode} - ${response.body}');
//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         return ApiResponse<AuthResponse>(
//           success: data['success'] ?? true,
//           message: data['message'] ?? 'OTP verified successfully',
//           data: AuthResponse.fromJson(data['data']),
//           meta: data['meta'] != null ? Meta.fromJson(data['meta']) : null,
//         );
//       } else {
//         return ApiResponse<AuthResponse>(
//           success: false,
//           message: data['message'] ?? 'OTP verification failed',
//           errors: data['errors'],
//         );
//       }
//     } catch (e) {
//       log('OTP Verify Error: $e');
//       return ApiResponse<AuthResponse>(
//         success: false,
//         message: 'Network error occurred',
//       );
//     }
//   }

//   // Resend OTP
//   Future<ApiResponse<void>> resendOtp({required String phone}) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/driver/otp/resend'),
//         headers: headers,
//         body: jsonEncode({'phone': phone}),
//       );

//       log('Resend OTP Response: ${response.statusCode} - ${response.body}');
//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         return ApiResponse<void>(
//           success: data['success'] ?? true,
//           message: data['message'] ?? 'OTP sent successfully',
//         );
//       } else {
//         return ApiResponse<void>(
//           success: false,
//           message: data['message'] ?? 'Failed to send OTP',
//           errors: data['errors'],
//         );
//       }
//     } catch (e) {
//       log('Resend OTP Error: $e');
//       return ApiResponse<void>(
//         success: false,
//         message: 'Network error occurred',
//       );
//     }
//   }

//   // Logout
//   Future<ApiResponse<void>> logoutDriver(String token) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/driver/logout'),
//         headers: headersWithAuth(token),
//       );

//       log('Logout Response: ${response.statusCode} - ${response.body}');
//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         return ApiResponse<void>(
//           success: data['success'] ?? true,
//           message: data['message'] ?? 'Logged out successfully',
//         );
//       } else {
//         return ApiResponse<void>(
//           success: false,
//           message: data['message'] ?? 'Logout failed',
//         );
//       }
//     } catch (e) {
//       log('Logout Error: $e');
//       return ApiResponse<void>(
//         success: false,
//         message: 'Network error occurred',
//       );
//     }
//   }

//   // ========================= USER SECTION =========================

//   Future<UserModel?> getUserProfile() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/user/profile'),
//         headers: headers,
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return UserModel.fromJson(data['data']);
//       }
//       return null;
//     } catch (e) {
//       log('Error getting user profile: $e');
//       return null;
//     }
//   }

//   Future<bool> updateUserProfile(UserModel user) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/user/profile'),
//         headers: headers,
//         body: jsonEncode(user.toJson()),
//       );
//       return response.statusCode == 200;
//     } catch (e) {
//       log('Error updating user profile: $e');
//       return false;
//     }
//   }

//   Future<bool> uploadProfileImage(String imagePath) async {
//     try {
//       final request = http.MultipartRequest(
//         'POST',
//         Uri.parse('$baseUrl/user/upload-image'),
//       );
//       request.headers.addAll(headers);
//       request.files.add(await http.MultipartFile.fromPath('image', imagePath));

//       final response = await request.send();
//       return response.statusCode == 200;
//     } catch (e) {
//       log('Error uploading image: $e');
//       return false;
//     }
//   }

//   Future<WalletModel?> getWalletData() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/wallet'),
//         headers: headers,
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return WalletModel.fromJson(data['data']);
//       }
//       return null;
//     } catch (e) {
//       log('Error getting wallet data: $e');
//       return null;
//     }
//   }

//   Future<bool> addMoneyToWallet(double amount, String paymentMethod) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/wallet/add-money'),
//         headers: headers,
//         body: jsonEncode({
//           'amount': amount,
//           'payment_method': paymentMethod,
//         }),
//       );
//       return response.statusCode == 200;
//     } catch (e) {
//       log('Error adding money: $e');
//       return false;
//     }
//   }

//   Future<List<NotificationModel>> getNotifications() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/notifications'),
//         headers: headers,
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return List<NotificationModel>.from(
//           data['data'].map((x) => NotificationModel.fromJson(x)),
//         );
//       }
//       return [];
//     } catch (e) {
//       log('Error getting notifications: $e');
//       return [];
//     }
//   }

//   Future<List<HistoryModel>> getHistory() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/history'),
//         headers: headers,
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return List<HistoryModel>.from(
//           data['data'].map((x) => HistoryModel.fromJson(x)),
//         );
//       }
//       return [];
//     } catch (e) {
//       log('Error getting history: $e');
//       return [];
//     }
//   }

//   Future<List<ReviewModel>> getCustomerReviews() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/reviews'),
//         headers: headers,
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return List<ReviewModel>.from(
//           data['data'].map((x) => ReviewModel.fromJson(x)),
//         );
//       }
//       return [];
//     } catch (e) {
//       log('Error getting reviews: $e');
//       return [];
//     }
//   }

//   Future<bool> sendSOSAlert(String location, String message) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/sos/alert'),
//         headers: headers,
//         body: jsonEncode({
//           'location': location,
//           'message': message,
//           'timestamp': DateTime.now().toIso8601String(),
//         }),
//       );
//       return response.statusCode == 200;
//     } catch (e) {
//       log('Error sending SOS alert: $e');
//       return false;
//     }
//   }
// }



import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:taxi_driver/data/models/history_model.dart';
import 'package:taxi_driver/data/models/notification_model.dart';
import 'package:taxi_driver/data/models/review_model.dart';
import 'package:taxi_driver/data/models/user_model.dart';
import 'package:taxi_driver/data/models/wallet_model.dart';
import 'package:taxi_driver/data/services/api_client.dart';

import '../models/api_response.dart';
import '../models/auth_models.dart';

class ApiService extends GetxService {
  static const String baseUrl = 'https://taxiportal.keyteh.site/api';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  ApiService(ApiClient find);

  Future<ApiResponse<AuthResponse>> registerDriver(Map<String, Object?> body, {
    required String firstName,
    required String lastName,
    required String email,
    required String phone_number,
    // required String password,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/driver/register'),
        headers: headers,
        body: jsonEncode({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phone_number,
          // 'password': password,
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        }),
      );

      log('Register Response: ${response.statusCode} - ${response.body}');
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<AuthResponse>(
          success: data['success'] ?? true,
          message: data['message'] ?? 'Registration successful',
          data: AuthResponse.fromJson(data['data']),
          meta: data['meta'] != null ? Meta.fromJson(data['meta']) : null,
        );
      } else {
        return ApiResponse<AuthResponse>(
          success: false,
          message: data['message'] ?? 'Registration failed',
          errors: data['errors'],
        );
      }
    } catch (e) {
      log('Register Error: $e');
      return ApiResponse<AuthResponse>(
        success: false,
        message: 'Network error occurred',
      );
    }
  }
Future<ApiResponse<AuthResponse>> loginDriver({
  required String identifier,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/driver/login'),
      headers: headers,
      body: jsonEncode({'identifier': identifier}),
    );

    log('Login Response: ${response.statusCode} - ${response.body}');
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ApiResponse<AuthResponse>(
        success: data['success'] ?? true,
        message: data['message'] ?? 'Login successful',
        // Safely handle null data
        data: data['data'] != null
            ? AuthResponse.fromJson(Map<String, dynamic>.from(data['data']))
            : null,
        meta: data['meta'] != null ? Meta.fromJson(data['meta']) : null,
      );
    } else {
      return ApiResponse<AuthResponse>(
        success: false,
        message: data['message'] ?? 'Login failed',
        errors: data['errors'],
      );
    }
  } catch (e) {
    log('Login Error: $e');
    return ApiResponse<AuthResponse>(
      success: false,
      message: 'Network error occurred',
    );
  }
}

Future<ApiResponse<AuthResponse>> verifyOtp({
  required String otp,
  required String phoneNumber,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/driver/otp/verify'),
      headers: headers,
      body: jsonEncode({
        'phone_number': phoneNumber,
        'otp': otp,
      }),
    );

    log('OTP Verify Response: ${response.statusCode} - ${response.body}');
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ApiResponse<AuthResponse>(
        success: data['success'] ?? true,
        message: data['message'] ?? 'OTP verified successfully',
        data: AuthResponse.fromJson(data['data']),
        meta: data['meta'] != null ? Meta.fromJson(data['meta']) : null,
      );
    } else {
      return ApiResponse<AuthResponse>(
        success: false,
        message: data['message'] ?? 'OTP verification failed',
        errors: data['errors'],
      );
    }
  } catch (e) {
    log('OTP Verify Error: $e');
    return ApiResponse<AuthResponse>(
      success: false,
      message: 'Network error occurred',
    );
  }
}

Future<ApiResponse<void>> resendOtp({
  required String phoneNumber,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/driver/otp/resend'),
      headers: headers,
      body: jsonEncode({'phone_number': phoneNumber}), // ✅ correct key
    );

    log('Resend OTP Response: ${response.statusCode} - ${response.body}');
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ApiResponse<void>(
        success: data['success'] ?? true,
        message: data['message'] ?? 'OTP sent successfully',
      );
    } else {
      return ApiResponse<void>(
        success: false,
        message: data['message'] ?? 'Failed to send OTP',
        errors: data['errors'],
      );
    }
  } catch (e) {
    log('Resend OTP Error: $e');
    return ApiResponse<void>(
      success: false,
      message: 'Network error occurred',
    );
  }
}


  Future<ApiResponse<void>> logoutDriver(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/driver/logout'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      log('Logout Response: ${response.statusCode} - ${response.body}');
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse<void>(
          success: data['success'] ?? true,
          message: data['message'] ?? 'Logged out successfully',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: data['message'] ?? 'Logout failed',
        );
      }
    } catch (e) {
      log('Logout Error: $e');
      return ApiResponse<void>(
        success: false,
        message: 'Network error occurred',
      );
    }
  }








  // ========================= USER SECTION =========================

  Future<UserModel?> getUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data['data']);
      }
      return null;
    } catch (e) {
      log('Error getting user profile: $e');
      return null;
    }
  }

  Future<bool> updateUserProfile(UserModel user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/profile'),
        headers: headers,
        body: jsonEncode(user.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      log('Error updating user profile: $e');
      return false;
    }
  }

  Future<bool> uploadProfileImage(String imagePath) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/user/upload-image'),
      );
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      final response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      log('Error uploading image: $e');
      return false;
    }
  }

  Future<WalletModel?> getWalletData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wallet'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WalletModel.fromJson(data['data']);
      }
      return null;
    } catch (e) {
      log('Error getting wallet data: $e');
      return null;
    }
  }

  Future<bool> addMoneyToWallet(double amount, String paymentMethod) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/wallet/add-money'),
        headers: headers,
        body: jsonEncode({
          'amount': amount,
          'payment_method': paymentMethod,
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      log('Error adding money: $e');
      return false;
    }
  }





Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/notifications'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<NotificationModel>.from(
          data['data'].map((x) => NotificationModel.fromJson(x)),
        );
      }
      return [];
    } catch (e) {
      log('Error getting notifications: $e');
      return [];
    }
  }

  Future<List<HistoryModel>> getHistory() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/history'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<HistoryModel>.from(
          data['data'].map((x) => HistoryModel.fromJson(x)),
        );
      }
      return [];
    } catch (e) {
      log('Error getting history: $e');
      return [];
    }
  }

  Future<List<ReviewModel>> getCustomerReviews() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reviews'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<ReviewModel>.from(
          data['data'].map((x) => ReviewModel.fromJson(x)),
        );
      }
      return [];
    } catch (e) {
      log('Error getting reviews: $e');
      return [];
    }
  }

  Future<bool> sendSOSAlert(String location, String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sos/alert'),
        headers: headers,
        body: jsonEncode({
          'location': location,
          'message': message,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      log('Error sending SOS alert: $e');
      return false;
    }
  }
}




