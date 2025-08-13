import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/wallet_model.dart';
import '../models/notification_model.dart';
import '../models/history_model.dart';
import '../models/review_model.dart';
import 'storage_service.dart';

class ApiService extends GetxService {
  static const String baseUrl = 'https://your-api-base-url.com/api';
  final StorageService _storage = Get.find<StorageService>();

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (_storage.userToken != null) 
      'Authorization': 'Bearer ${_storage.userToken}',
  };

  // User APIs
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
      print('Error getting user profile: $e');
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
      print('Error updating user profile: $e');
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
      print('Error uploading image: $e');
      return false;
    }
  }

  // Wallet APIs
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
      print('Error getting wallet data: $e');
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
      print('Error adding money: $e');
      return false;
    }
  }

  // Notification APIs
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/notifications'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<NotificationModel>.from(
          data['data'].map((x) => NotificationModel.fromJson(x))
        );
      }
      return [];
    } catch (e) {
      print('Error getting notifications: $e');
      return [];
    }
  }

  // History APIs
  Future<List<HistoryModel>> getHistory() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/history'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<HistoryModel>.from(
          data['data'].map((x) => HistoryModel.fromJson(x))
        );
      }
      return [];
    } catch (e) {
      print('Error getting history: $e');
      return [];
    }
  }



  // Reviews APIs
  Future<List<ReviewModel>> getCustomerReviews() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reviews'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<ReviewModel>.from(
          data['data'].map((x) => ReviewModel.fromJson(x))
        );
      }
      return [];
    } catch (e) {
      print('Error getting reviews: $e');
      return [];
    }
  }

  // SOS API
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
      print('Error sending SOS alert: $e');
      return false;
    }
  }
}
