import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/chat/controller/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  final TextEditingController _messageController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://via.placeholder.com/36'),
              child: Text(
                controller.customerName.value.isNotEmpty 
                  ? controller.customerName.value[0].toUpperCase()
                  : 'C',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.customerName.value.isNotEmpty 
                      ? controller.customerName.value
                      : 'Customer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(() => Text(
                    controller.connectionStatus.value == 'connected' 
                      ? 'Online' 
                      : 'Offline',
                    style: TextStyle(
                      color: controller.connectionStatus.value == 'connected' 
                        ? Colors.green 
                        : Colors.grey,
                      fontSize: 12,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: controller.callCustomer,
            icon: Icon(Icons.call, color: Colors.green[600]),
          ),
        ],
      ),
      body: Obx(() => controller.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // Quick Action Messages
              Container(
                height: 60,
                color: Colors.white,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    _buildQuickMessageChip('On my way', 'on_way'),
                    SizedBox(width: 8),
                    _buildQuickMessageChip('Arrived', 'arrived'),
                    SizedBox(width: 8),
                    _buildQuickMessageChip('Running late', 'traffic'),
                    SizedBox(width: 8),
                    _buildQuickMessageChip('Call me', 'call_me'),
                  ],
                ),
              ),
              
              Divider(height: 1),
              
              // Messages List
              Expanded(
                child: controller.messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Start a conversation',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.all(16),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[controller.messages.length - 1 - index];
                        return _buildMessageBubble(message);
                      },
                    ),
              ),
              
              // Message Input
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            maxLines: null,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (_messageController.text.trim().isNotEmpty) {
                            controller.sendMessage(_messageController.text);
                            _messageController.clear();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[600],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
  
  Widget _buildQuickMessageChip(String text, String type) {
    return GestureDetector(
      onTap: () => controller.sendQuickMessage(type),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.red[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  
  Widget _buildMessageBubble(message) {
    bool isFromDriver = message.isFromDriver;
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isFromDriver 
          ? CrossAxisAlignment.end 
          : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.75,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isFromDriver 
                ? Colors.red[600] 
                : Colors.white,
              borderRadius: BorderRadius.circular(20).copyWith(
                bottomLeft: isFromDriver 
                  ? Radius.circular(20) 
                  : Radius.circular(4),
                bottomRight: isFromDriver 
                  ? Radius.circular(4) 
                  : Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.content,
              style: TextStyle(
                color: isFromDriver ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            _formatTime(message.timestamp),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
