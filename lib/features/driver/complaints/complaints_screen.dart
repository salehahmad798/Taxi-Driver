import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/complaints/complaints_controller.dart';

class ComplaintsView extends GetView<ComplaintsController> {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Make Complaints")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Your Complaint",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => controller.complaintText.value = val,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle complaint submission
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
