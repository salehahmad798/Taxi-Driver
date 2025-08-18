import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taxi_driver/core/constants/network_constants.dart';
import 'package:taxi_driver/core/error/network_exception.dart';
import 'package:taxi_driver/core/utils/logger.dart';
import 'package:taxi_driver/data/services/storage_service.dart';

class ApiClient {
  final StorageService _storage;
  ApiClient(this._storage);

  Uri _uri(String path) => Uri.parse('${NetworkConstants.baseUrl}$path');

  Map<String, String> _headers({bool auth = false}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // if (auth) {
    //   final token = _storage.getToken();
    //   if (token != null) headers['Authorization'] = 'Bearer $token';
    // }
    if (auth) {
      final token = _storage.getAccessToken();
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<Map<String, dynamic>> get(String path, {bool auth = true}) async {
    final url = _uri(path);
    logRequest('GET', url.toString());
    final res = await http.get(url, headers: _headers(auth: auth));
    return _handle(res, path);
  }

  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic>? body, bool auth = true}) async {
    final url = _uri(path);
    logRequest('POST', url.toString());
    final res = await http.post(url,
        headers: _headers(auth: auth), body: jsonEncode(body ?? {}));
    return _handle(res, path);
  }

  Future<Map<String, dynamic>> put(String path,
      {Map<String, dynamic>? body, bool auth = true}) async {
    final url = _uri(path);
    logRequest('PUT', url.toString());
    final res = await http.put(url,
        headers: _headers(auth: auth), body: jsonEncode(body ?? {}));
    return _handle(res, path);
  }

  Future<Map<String, dynamic>> delete(String path, {bool auth = true}) async {
    final url = _uri(path);
    logRequest('DELETE', url.toString());
    final res = await http.delete(url, headers: _headers(auth: auth));
    return _handle(res, path);
  }

  Map<String, dynamic> _handle(http.Response res, String path) {
    final body = res.body.isEmpty ? '{}' : res.body;
    final json = jsonDecode(body);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return json is Map<String, dynamic> ? json : {'data': json};
    }
    throw NetworkException.fromStatusCode(res.statusCode, path, body);
  }
}
