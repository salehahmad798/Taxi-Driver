import 'package:get/get.dart';
import 'package:taxi_driver/data/providers/api_provider.dart';
import 'package:taxi_driver/features/driver/document_upload/document_upload_controller.dart';

class DocumentUploadBinding extends Bindings {
  @override
  void dependencies() {
  // Get.lazyPut<ApiProvider>(
  //     () => ApiProvider(),
  //   );
    Get.lazyPut<DocumentUploadController>(() => DocumentUploadController());
  }
}
