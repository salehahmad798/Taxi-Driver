import 'package:get/get.dart';
import 'package:taxi_driver/data/models/notification_model.dart';
import 'package:taxi_driver/data/services/api_service.dart';

class NotificationController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading(true);
      error('');
      
      final notificationList = await _apiService.getNotifications();
      notifications.assignAll(notificationList);
    } catch (e) {
      error('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
