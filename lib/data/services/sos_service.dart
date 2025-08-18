import 'package:taxi_driver/core/constants/network_constants.dart';
import 'package:taxi_driver/data/services/api_client.dart';

class SosService {
  final ApiClient _api;
  SosService(this._api);

  Future<bool> sendAlert(String location, String message) async {
    final res = await _api.post(NetworkConstants.sosAlert, body: {
      'location': location,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
    return (res['success'] ?? false) == true;
  }
}
