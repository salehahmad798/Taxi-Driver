// 7. SERVICE INITIALIZATION (app/data/services/service_init.dart)
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/services/document_services.dart';
import 'chat_service.dart';
import 'ride_service.dart';
import 'location_service.dart';

class ServiceInit {
  static void init() {
    // Initialize all services as singletons
    Get.put<ChatService>(ChatService(), permanent: true);
    Get.put<RideService>(RideService(), permanent: true);
    Get.put<DocumentService>(DocumentService(), permanent: true);
    Get.put<LocationService>(LocationService(), permanent: true);
  }
}