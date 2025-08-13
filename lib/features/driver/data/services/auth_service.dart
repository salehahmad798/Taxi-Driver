import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:taxi_driver/features/driver/data/services/network_exception.dart';

class AuthService {
  final String baseUrl = 'YOUR_API_BASE_URL';
  final GetStorage _storage = GetStorage();
  
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _refreshTokenKey = 'refresh_token';

  // Login driver
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'user_type': 'driver',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Store tokens and user data
        await _storage.write(_tokenKey, data['access_token']);
        await _storage.write(_refreshTokenKey, data['refresh_token']);
        await _storage.write(_userKey, data['user']);
        
        return true;
      } else {
        throw NetworkException.fromStatusCode(response.statusCode, '/auth/login');
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Logout driver
  Future<void> logout() async {
    try {
      final token = getToken();
      if (token != null) {
        await http.post(
          Uri.parse('$baseUrl/auth/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
      }
    } catch (e) {
      print('Logout error: $e');
    } finally {
      // Clear local storage
      await _storage.remove(_tokenKey);
      await _storage.remove(_refreshTokenKey);
      await _storage.remove(_userKey);
    }
  }

  // Get stored token
  String? getToken() {
    return _storage.read(_tokenKey);
  }

  // Get user data
  Map<String, dynamic>? getUserData() {
    return _storage.read(_userKey);
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return getToken() != null;
  }

  // Refresh token
  Future<bool> refreshToken() async {
    try {
      final refreshToken = _storage.read(_refreshTokenKey);
      if (refreshToken == null) return false;

      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _storage.write(_tokenKey, data['access_token']);
        return true;
      }
      
      return false;
    } catch (e) {
      print('Refresh token error: $e');
      return false;
    }
  }

  // Update profile
  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/drivers/profile'),
        headers: {
          'Authorization': 'Bearer ${getToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profileData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _storage.write(_userKey, data['user']);
        return true;
      }

      return false;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }
}