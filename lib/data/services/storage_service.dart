import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/auth_models.dart';

class StorageService {
  static StorageService? _instance;
  late SharedPreferences _prefs;

  // Private constructor
  StorageService._();

  /// Initialize the StorageService instance (call once on app start)
  static Future<StorageService> init() async {
    if (_instance == null) {
      final service = StorageService._();
      service._prefs = await SharedPreferences.getInstance();
      _instance = service;
    }
    return _instance!;
  }

  /// Singleton instance getter - throws if used before init()
  static StorageService get instance {
    if (_instance == null) {
      throw Exception(
          "StorageService not initialized. Call StorageService.init() first.");
    }
    return _instance!;
  }

  /// -------- Preference Keys --------
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyAccessToken = 'access_token';
  static const String _keyTokenType = 'token_type';
  static const String _keyUserData = 'user_data';
  static const String _keyIsFirstTime = 'is_first_time';
  static const String _keyPhoneNumber = 'phone_number';
  static const String _keyRefreshToken = 'refresh_token';

  /// -------- First Time User --------
  Future<bool> isFirstTimeUser() async {
    return _prefs.getBool(_keyIsFirstTime) ?? true;
  }

  Future<void> setFirstTimeUser(bool isFirstTime) async {
    await _prefs.setBool(_keyIsFirstTime, isFirstTime);
  }

  /// -------- Logged In State --------
  Future<bool> isLoggedIn() async {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_keyIsLoggedIn, value);
  }

  /// -------- Access Token --------
  Future<void> saveAccessToken(String token) async {
    await _prefs.setString(_keyAccessToken, token);
  }

  String? getAccessToken() {
    return _prefs.getString(_keyAccessToken);
  }

  Future<void> removeAccessToken() async {
    await _prefs.remove(_keyAccessToken);
  }

  /// -------- Token Type --------
  Future<void> setTokenType(String tokenType) async {
    await _prefs.setString(_keyTokenType, tokenType);
  }

  String? getTokenType() {
    return _prefs.getString(_keyTokenType);
  }

  /// -------- Refresh Token --------
  Future<void> saveRefreshToken(String refreshToken) async {
    await _prefs.setString(_keyRefreshToken, refreshToken);
  }

  String? getRefreshToken() {
    return _prefs.getString(_keyRefreshToken);
  }

  Future<void> removeRefreshToken() async {
    await _prefs.remove(_keyRefreshToken);
  }

  /// -------- User Data --------
  Future<User?> getUserData() async {
    final String? userJson = _prefs.getString(_keyUserData);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> setUserData(User user) async {
    final String userJson = jsonEncode(user.toJson());
    await _prefs.setString(_keyUserData, userJson);
  }

  /// -------- Phone Number --------
  Future<String?> getPhoneNumber() async {
    return _prefs.getString(_keyPhoneNumber);
  }

  Future<void> setPhoneNumber(String phoneNumber) async {
    await _prefs.setString(_keyPhoneNumber, phoneNumber);
  }

  /// -------- Save complete auth data --------
  Future<void> saveAuthData(AuthResponse authResponse) async {
    await Future.wait([
      setLoggedIn(true),
      saveAccessToken(authResponse.accessToken),
      setTokenType(authResponse.tokenType),
      setUserData(authResponse.user),
      setPhoneNumber(authResponse.user.phone),
      setFirstTimeUser(false),
    ]);
  }

  /// -------- Get full auth token with type --------
  Future<String?> getFullToken() async {
    final tokenType = getTokenType();
    final accessToken = getAccessToken();

    if (tokenType != null && accessToken != null) {
      return '$tokenType $accessToken';
    }
    return null;
  }

  /// -------- Clear all user data --------
  Future<void> clearUserData() async {
    await Future.wait([
      removeAccessToken(),
      _prefs.remove(_keyTokenType),
      _prefs.remove(_keyUserData),
      _prefs.remove(_keyPhoneNumber),
      removeRefreshToken(),
      _prefs.setBool(_keyIsLoggedIn, false),
      // Keep _keyIsFirstTime intact to prevent onboarding repetition unless explicitly reset
    ]);
  }

  /// -------- Clear only session data --------
  Future<void> clearSessionData() async {
    await Future.wait([
      removeAccessToken(),
      _prefs.remove(_keyTokenType),
      _prefs.remove(_keyUserData),
      removeRefreshToken(),
      _prefs.setBool(_keyIsLoggedIn, false),
    ]);
  }

  /// -------- Generic Helpers --------
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<void> saveStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
