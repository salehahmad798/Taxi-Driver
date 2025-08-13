// lib/app/bindings/wallet_binding.dart
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/wallet/wallet_controller.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(() => WalletController());
  }
}