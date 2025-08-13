import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/chat/controller/chat_controller.dart';
import 'package:taxi_driver/features/driver/data/services/chat_service.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatService>(() => ChatService());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
