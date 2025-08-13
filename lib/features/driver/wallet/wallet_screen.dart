import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/wallet/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Wallet Balance Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(() => Text(
                    "TZS${controller.balance.value.toStringAsFixed(0)}",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(height: 16),

            // Transactions List
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.transactions.length,
                    itemBuilder: (_, index) {
                      final tx = controller.transactions[index];
                      return ListTile(
                        title: Text(tx['title']),
                        subtitle: Text(tx['date']),
                        trailing: Text(
                          "TZS${tx['amount']}",
                          style: TextStyle(
                            color: tx['amount'] < 0 ? Colors.red : Colors.green,
                          ),
                        ),
                      );
                    },
                  )),
            ),

            // Add Money Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () => _showPaymentMethodBottomSheet(context),
              child: const Text('Add Money'),
            )
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Payment Method Selection
            Obx(() => RadioListTile(
                  value: 'stripe',
                  groupValue: selectedMethod.value,
                  onChanged: (val) => selectedMethod.value = val!,
                  title: const Text(
                    'Stripe',
                    style: TextStyle(color: Colors.blue),
                  ),
                )),
            Obx(() => RadioListTile(
                  value: 'paypal',
                  groupValue: selectedMethod.value,
                  onChanged: (val) => selectedMethod.value = val!,
                  title: const Text(
                    'PayPal',
                    style: TextStyle(color: Colors.blue),
                  ),
                )),

            const SizedBox(height: 12),

            // Amount Field
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Add Money Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                if (amountController.text.isNotEmpty) {
                  double amount = double.tryParse(amountController.text) ?? 0;
                  controller.addMoney(amount, selectedMethod.value);
                  Get.back(); // Close bottom sheet
                }
              },
              child: const Text('Add Money'),
            )
          ],
        ),
      ),
    );
  }
}
