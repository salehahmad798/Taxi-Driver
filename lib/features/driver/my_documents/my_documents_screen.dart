import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/my_documents/my_documents_controller.dart';

class MyDocumentsScreen extends GetView<MyDocumentsController> {
  const MyDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Documents")),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.documents.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
              title: Text(controller.documents[index]),
              trailing: IconButton(
                icon: const Icon(Icons.upload_file),
                onPressed: () {
                  // Upload logic
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
