import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:taxi_driver/core/constants/network_constants.dart';
import 'package:taxi_driver/data/models/user_model.dart';
import 'package:taxi_driver/data/services/storage_service.dart';

class UserService {
  final StorageService _storage = StorageService.instance;

  Future<UserModel?> getProfile() async {
    // final token = await _storage.getToken();
    final token = _storage.getAccessToken();



    final uri = Uri.parse('${NetworkConstants.baseUrl}${NetworkConstants.userProfile}');

    final res = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      final data = userResponseJson(res.body);
      return UserModel.fromJson(data['data']);
    }
    return null;
  }

  Future<bool> updateProfile(UserModel user) async {
    // final token = await _storage.getToken();
    final token = _storage.getAccessToken();
    final uri = Uri.parse('${NetworkConstants.baseUrl}${NetworkConstants.userProfile}');

    final res = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: userResponseEncode(user.toJson()),
    );

    return res.statusCode == 200;
  }

  Future<bool> uploadProfileImage(String imagePath) async {
    // final token = await _storage.getToken();
    final token = _storage.getAccessToken();

    final uri = Uri.parse('${NetworkConstants.baseUrl}${NetworkConstants.uploadImage}');

    final request = http.MultipartRequest('POST', uri);
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imagePath,
        filename: File(imagePath).uri.pathSegments.last,
      ),
    );

    final res = await request.send();
    return res.statusCode == 200;
  }
}

// Helpers (replace with proper JSON parsing in real code)
Map<String, dynamic> userResponseJson(String body) => body.isEmpty ? {} : {};
String userResponseEncode(Map<String, dynamic> map) => map.toString();
