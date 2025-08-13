import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/my_documents/my_documents_controller.dart';

class MyDocumentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDocumentsController>(() => MyDocumentsController());
  }
}
