import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  // SharedPreferences instance
  late SharedPreferences _prefs;

  // GetStorage instance
  static final GetStorage _box = GetStorage();

  // Initialize both storages
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    await GetStorage.init();
    return this;
  }

  // ----------------------------
  // SharedPreferences (User Data)
  // ----------------------------
  String? get userToken => _prefs.getString('user_token');
  set userToken(String? value) => _prefs.setString('user_token', value ?? '');

  String? get userId => _prefs.getString('user_id');
  set userId(String? value) => _prefs.setString('user_id', value ?? '');

  String? get userName => _prefs.getString('user_name');
  set userName(String? value) => _prefs.setString('user_name', value ?? '');

  String? get userEmail => _prefs.getString('user_email');
  set userEmail(String? value) => _prefs.setString('user_email', value ?? '');

  String? get userPhone => _prefs.getString('user_phone');
  set userPhone(String? value) => _prefs.setString('user_phone', value ?? '');

  String? get userImage => _prefs.getString('user_image');
  set userImage(String? value) => _prefs.setString('user_image', value ?? '');

  void clearUserData() {
    _prefs.remove('user_token');
    _prefs.remove('user_id');
    _prefs.remove('user_name');
    _prefs.remove('user_email');
    _prefs.remove('user_phone');
    _prefs.remove('user_image');
  }

  // ----------------------------
  // GetStorage (Lightweight Data)
  // ----------------------------
  static Future<void> save(String key, dynamic value) async {
    await _box.write(key, value);
  }

  static T? read<T>(String key) {
    return _box.read<T>(key);
  }

  static Future<void> remove(String key) async {
    await _box.remove(key);
  }

  static Future<void> clear() async {
    await _box.erase();
  }

  static bool hasKey(String key) {
    return _box.hasData(key);
  }

  // ----------------------------
  // Driver Settings
  // ----------------------------
  static Future<void> saveDriverSettings({
    bool? notificationsEnabled,
    bool? locationTracking,
    String? preferredLanguage,
    bool? autoAcceptRides,
  }) async {
    final settings = {
      'notifications_enabled': notificationsEnabled,
      'location_tracking': locationTracking,
      'preferred_language': preferredLanguage,
      'auto_accept_rides': autoAcceptRides,
    };
    await save('driver_settings', settings);
  }

  static Map<String, dynamic> getDriverSettings() {
    return read('driver_settings') ?? {
      'notifications_enabled': true,
      'location_tracking': true,
      'preferred_language': 'en',
      'auto_accept_rides': false,
    };
  }

  // ----------------------------
  // Ride Cache
  // ----------------------------
  static Future<void> cacheRideData(String rideId, Map<String, dynamic> data) async {
    await save('ride_cache_$rideId', data);
  }

  static Map<String, dynamic>? getCachedRideData(String rideId) {
    return read('ride_cache_$rideId');
  }

  static Future<void> clearRideCache(String rideId) async {
    await remove('ride_cache_$rideId');
  }
}
