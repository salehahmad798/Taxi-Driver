// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notifications = 
//       FlutterLocalNotificationsPlugin();

//   // Initialize notifications
//   static Future<void> init() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     const initializationSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );

//     await _notifications.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: _onNotificationTapped,
//     );
//   }

//   // Show ride request notification
//   static Future<void> showRideRequestNotification({
//     required String customerName,
//     required String pickupLocation,
//     required double fare,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'ride_requests',
//       'Ride Requests',
//       channelDescription: 'Notifications for new ride requests',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );

//     const iosDetails = DarwinNotificationDetails();

//     const notificationDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await _notifications.show(
//       0,
//       'New Ride Request',
//       '$customerName wants a ride from $pickupLocation - ₦${fare.toStringAsFixed(0)}',
//       notificationDetails,
//     );
//   }

//   // Show trip status notification
//   static Future<void> showTripStatusNotification({
//     required String title,
//     required String message,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'trip_status',
//       'Trip Status',
//       channelDescription: 'Notifications for trip status updates',
//       importance: Importance.defaultImportance,
//       priority: Priority.defaultPriority,
//     );

//     const iosDetails = DarwinNotificationDetails();

//     const notificationDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await _notifications.show(
//       1,
//       title,
//       message,
//       notificationDetails,
//     );
//   }

//   // Handle notification tap
//   static void _onNotificationTapped(NotificationResponse response) {
//     // Handle notification tap based on payload
//     print('Notification tapped: ${response.payload}');
//   }

//   // Cancel all notifications
//   static Future<void> cancelAllNotifications() async {
//     await _notifications.cancelAll();
//   }
// }


import 'package:taxi_driver/core/constants/network_constants.dart';
import 'package:taxi_driver/data/models/notification_model.dart';
import 'package:taxi_driver/data/services/api_client.dart';

class NotificationService {
  final ApiClient _api;
  NotificationService(this._api);

  Future<List<NotificationModel>> getNotifications() async {
    final res = await _api.get(NetworkConstants.notifications);
    final list = (res['data'] as List?) ?? [];
    return list.map((e) => NotificationModel.fromJson(e)).toList();
  }
}
