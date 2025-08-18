// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../data/models/auth_models.dart';

// class StorageService {
//   static const _keyIsLoggedIn = 'is_logged_in';
//   static const _keyAccessToken = 'access_token';
//   static const _keyTokenType = 'token_type';
//   static const _keyUserData = 'user_data';
//   static const _keyIsFirstTime = 'is_first_time';
//   static const _keyPhoneNumber = 'phone_number';

//   Future<bool> isFirstTimeUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_keyIsFirstTime) ?? true;
//   }

//   Future<void> setFirstTimeUser(bool isFirstTime) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_keyIsFirstTime, isFirstTime);
//   }

//   Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_keyIsLoggedIn) ?? false;
//   }

//   Future<void> setLoggedIn(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_keyIsLoggedIn, value);
//   }

//   Future<void> saveAuthData(AuthResponse data) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_keyIsLoggedIn, true);
//     await prefs.setString(_keyAccessToken, data.accessToken);
//     await prefs.setString(_keyTokenType, data.tokenType);
//     await prefs.setString(_keyUserData, jsonEncode(data.user.toJson()));
//     await prefs.setString(_keyPhoneNumber, data.user.phone);
//     await prefs.setBool(_keyIsFirstTime, false);
//   }

//   Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAccessToken);
//   }

//   Future<String?> getTokenType() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyTokenType);
//   }

//   Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyAccessToken);
//     await prefs.remove(_keyTokenType);
//     await prefs.remove(_keyUserData);
//     await prefs.remove(_keyPhoneNumber);
//     await prefs.setBool(_keyIsLoggedIn, false);
//   }
// }
