import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_appbar.dart';
import 'package:taxi_driver/core/widgets/primary_button.dart';
import 'package:taxi_driver/features/driver/wallet/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: CustomAppBar(text: 'Wallet'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(
                () => Text(
                  "TZS${controller.balance.value.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (_, index) {
                    final tx = controller.transactions[index];
                    return ListTile(
                      title: Text(tx['title']),
                      subtitle: Text(tx['date']),
                      trailing: Text(
                        "TZS${tx['amount']}",
                        style: TextStyle(
                          color: tx['amount'] < 0
                              ? AppColors.kprimaryColor
                              : Colors.green,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            PrimaryButton(
              text: 'Add Money',
              onTap: () => _showPaymentMethodBottomSheet(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentMethodBottomSheet(BuildContext context) {
    var selectedMethod = 'stripe'.obs;
    var amountController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
          
              Obx(
                () => RadioListTile(
                  value: 'stripe',
                  groupValue: selectedMethod.value,
                  onChanged: (val) => selectedMethod.value = val!,
                  title: Text(
                    'Stripe',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Obx(
                () => RadioListTile(
                  value: 'paypal',
                  groupValue: selectedMethod.value,
                  onChanged: (val) => selectedMethod.value = val!,
                  title: Text(
                    'PayPal',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 12),
          
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Enter Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
          
              PrimaryButton(
                text: 'Add Money',
                width: double.infinity,
                onTap: () {
                  if (amountController.text.isNotEmpty) {
                    double amount = double.tryParse(amountController.text) ?? 0;
                    controller.addMoney(amount, selectedMethod.value);
                    Get.back(); 
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
