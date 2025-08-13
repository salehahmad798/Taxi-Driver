import 'package:flutter/material.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {"type": "System", "message": "Your booking #5445 has been succe..."},
    {"type": "Promotion", "message": "Invite friends - Get 3 coupons each!"},
    {"type": "System", "message": "Thank You! Your transaction is compl..."},
    {"type": "Promotion", "message": "Invite friends - Get 3 coupons each!"},
    {"type": "System", "message": "Your booking #5445 has been succe..."},
    {"type": "Promotion", "message": "Invite friends - Get 3 coupons each!"},
  ];

   NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:AppColors.primaryappcolor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["type"] ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: item["type"] == "Promotion" ? AppColors.primaryappcolor : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item["message"] ?? "",
                  style: TextStyle(color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
