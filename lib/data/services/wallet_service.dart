import 'package:taxi_driver/core/constants/network_constants.dart';
import 'package:taxi_driver/data/models/wallet_model.dart';
import 'package:taxi_driver/data/services/api_client.dart';

class WalletService {
  final ApiClient _api;
  WalletService(this._api);

  Future<WalletModel?> getWallet() async {
    final res = await _api.get(NetworkConstants.wallet);
    if (res['data'] != null) return WalletModel.fromJson(res['data']);
    return null;
  }

  Future<bool> addMoney(double amount, String paymentMethod) async {
    final res = await _api.post(NetworkConstants.addMoney, body: {
      'amount': amount,
      'payment_method': paymentMethod,
    });
    return (res['success'] ?? false) == true;
  }
}
