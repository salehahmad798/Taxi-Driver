// lib/app/views/add_money_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMoneyView extends StatelessWidget {
  const AddMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    var amountController = TextEditingController(text: 'TZS100');
    var presetAmounts = ['TZS100', 'TZS500', 'TZS1000'].obs;
    var selectedPreset = 'TZS100'.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    suffixText: 'TZS',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: presetAmounts.map((preset) {
                        return ChoiceChip(
                          label: Text(preset),
                          selected: selectedPreset.value == preset,
                          onSelected: (val) {
                            selectedPreset.value = preset;
                            amountController.text = preset;
                          },
                        );
                      }).toList(),
                    )),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {},
                        child: const Text('Add Money'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
