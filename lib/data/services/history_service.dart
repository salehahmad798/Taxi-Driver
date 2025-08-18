import 'package:taxi_driver/core/constants/network_constants.dart';
import 'package:taxi_driver/data/models/history_model.dart';
import 'package:taxi_driver/data/services/api_client.dart';

class HistoryService {
  final ApiClient _api;
  HistoryService(this._api);

  Future<List<HistoryModel>> getHistory() async {
    final res = await _api.get(NetworkConstants.history);
    final list = (res['data'] as List?) ?? [];
    return list.map((e) => HistoryModel.fromJson(e)).toList();
  }
}
