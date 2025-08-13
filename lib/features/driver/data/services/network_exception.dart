class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final String? endpoint;

  NetworkException({
    required this.message,
    this.statusCode,
    this.endpoint,
  });

  @override
  String toString() {
    return 'NetworkException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }

  static NetworkException fromStatusCode(int statusCode, String endpoint) {
    String message;
    
    switch (statusCode) {
      case 400:
        message = 'Bad request - Please check your input';
        break;
      case 401:
        message = 'Unauthorized - Please login again';
        break;
      case 403:
        message = 'Forbidden - You don\'t have permission';
        break;
      case 404:
        message = 'Not found - Resource doesn\'t exist';
        break;
      case 422:
        message = 'Validation error - Invalid data provided';
        break;
      case 500:
        message = 'Server error - Please try again later';
        break;
      case 503:
        message = 'Service unavailable - Server is down';
        break;
      default:
        message = 'Network error occurred';
    }

    return NetworkException(
      message: message,
      statusCode: statusCode,
      endpoint: endpoint,
    );
  }
}