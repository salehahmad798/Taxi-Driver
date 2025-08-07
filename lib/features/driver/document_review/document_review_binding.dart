
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/providers/api_provider.dart';
import 'package:taxi_driver/features/driver/document_review/document_review_controller.dart';

class DocumentReviewBinding extends Bindings {
  @override
  void dependencies() {
    // API Provider for making HTTP requests
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );

    // Document Review Controller
    Get.lazyPut<DocumentReviewController>(
      () => DocumentReviewController(),
    );
  }
}