class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final String? path;

  NetworkException(this.message, {this.statusCode, this.path});

  @override
  String toString() => 'NetworkException($statusCode, $path): $message';

  static NetworkException fromStatusCode(int code, String path, [String? body]) {
    final msg = body ?? _defaultMessage(code);
    return NetworkException(msg, statusCode: code, path: path);
  }

  static String _defaultMessage(int code) {
    if (code >= 500) return 'Server error. Please try again later.';
    if (code == 401) return 'Unauthorized. Please log in again.';
    if (code == 403) return 'Forbidden. You do not have access.';
    if (code == 404) return 'Not found.';
    if (code == 422) return 'Validation error.';
    return 'Request failed ($code).';
  }
}
