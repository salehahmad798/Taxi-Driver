// lightweight logger to keep logs consistent
void logRequest(String method, String url) {
  // ignore: avoid_print
  print('[HTTP] $method $url');
}

void logResponse(int code, String body) {
  // ignore: avoid_print
  print('[HTTP] <- $code : $body');
}

void logError(String where, Object e) {
  // ignore: avoid_print
  print('[ERROR] $where : $e');
}
