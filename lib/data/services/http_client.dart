import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  static const String baseUrl = 'YOUR_API_BASE_URL';
  static const Duration timeout = Duration(seconds: 30);

  // GET request
  static Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(headers),
      ).timeout(timeout);
      
      _logRequest('GET', endpoint, response.statusCode);
      return response;
    } catch (e) {
      _logError('GET', endpoint, e);
      rethrow;
    }
  }

  // POST request
  static Future<http.Response> post(String endpoint, {Object? body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(headers),
        body: body,
      ).timeout(timeout);
      
      _logRequest('POST', endpoint, response.statusCode);
      return response;
    } catch (e) {
      _logError('POST', endpoint, e);
      rethrow;
    }
  }

  // PUT request
  static Future<http.Response> put(String endpoint, {Object? body, Map<String, String>? headers}) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(headers),
        body: body,
      ).timeout(timeout);
      
      _logRequest('PUT', endpoint, response.statusCode);
      return response;
    } catch (e) {
      _logError('PUT', endpoint, e);
      rethrow;
    }
  }

  // DELETE request
  static Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(headers),
      ).timeout(timeout);
      
      _logRequest('DELETE', endpoint, response.statusCode);
      return response;
    } catch (e) {
      _logError('DELETE', endpoint, e);
      rethrow;
    }
  }

  // Get default headers
  static Map<String, String> _getHeaders(Map<String, String>? additionalHeaders) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  // Log request
  static void _logRequest(String method, String endpoint, int statusCode) {
    print('$method $endpoint - Status: $statusCode');
  }

  // Log error
  static void _logError(String method, String endpoint, dynamic error) {
    print('ERROR: $method $endpoint - $error');
  }

  // Helper method to handle response
  static Map<String, dynamic> handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      }
      return {};
    } else {
      throw Exception('HTTP Error: ${response.statusCode} - ${response.body}');
    }
  }
}
