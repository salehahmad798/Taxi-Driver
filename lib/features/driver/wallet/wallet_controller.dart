import 'package:get/get.dart';
import 'package:taxi_driver/data/services/api_service.dart';

class WalletController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  /// Instead of one WalletModel, split into reactive balance & transactions
  final RxDouble balance = 0.0.obs;
  final RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadWalletData();
  }

  Future<void> loadWalletData() async {
    try {
      isLoading(true);
      error('');

      final walletData = await _apiService.getWalletData();
      if (walletData != null) {
        balance.value = walletData.balance ?? 0.0;
        transactions.assignAll((walletData.transactions ?? []) as Iterable<Map<String, dynamic>>);
      } else {
        error('Failed to load wallet data');
      }
    } catch (e) {
      error('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  void addMoney(double amount, String method) {
    balance.value += amount;
    transactions.insert(0, {
      'title': 'Added via $method',
      'date': DateTime.now().toString(),
      'amount': amount,
    });
  }
}
