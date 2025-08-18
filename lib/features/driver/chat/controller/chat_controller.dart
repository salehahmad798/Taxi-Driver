import 'package:get/get.dart';
import 'package:taxi_driver/data/models/message_model.dart';
import 'package:taxi_driver/data/services/chat_service.dart';
import 'package:taxi_driver/features/driver/pickup/model/ride_request_model.dart';

class ChatController extends GetxController {
  final ChatService _chatService = Get.find();
  
  // Chat data
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isTyping = false.obs;
  final RxString connectionStatus = 'connected'.obs;
  final RxBool isLoading = false.obs;
  
  // Current ride info for context
  late Rx<RideRequestModel> currentRide;
  final RxString customerName = "".obs;
  final RxString customerAvatar = "".obs;

  @override
  void onInit() {
    super.onInit();
    
    if (Get.arguments != null) {
      currentRide = Rx<RideRequestModel>(Get.arguments as RideRequestModel);
      customerName(currentRide.value.customerName);
    }
    
    initializeChat();
  }

  Future<void> initializeChat() async {
    isLoading(true);
    try {
      await connectToChat();
      await loadChatHistory();
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize chat');
    } finally {
      isLoading(false);
    }
  }

  Future<void> connectToChat() async {
    _chatService.connect(currentRide.value.id);
    
    // Listen for incoming messages
    _chatService.onMessageReceived((message) {
      // messages.add(message);
      scrollToBottom();
    });
    
    // Listen for connection status changes
    _chatService.onConnectionStatusChanged((status) {
      connectionStatus(status);
    });
    
    // Listen for typing indicators
    _chatService.onTypingStatusChanged((isCustomerTyping) {
      // Handle customer typing indicator
    });
  }

  Future<void> loadChatHistory() async {
    try {
      final history = await _chatService.getChatHistory(currentRide.value.id);
      messages.assignAll(history);
      scrollToBottom();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load chat history');
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      rideId: currentRide.value.id,
      content: content.trim(),
      timestamp: DateTime.now(),
      isFromDriver: true,
      senderName: "You",
    );

    // Add to local list immediately for better UX
    messages.add(message);
    scrollToBottom();
    
    // Send to server
    try {
      await _chatService.sendMessage(message);
    } catch (e) {
      // Mark message as failed if needed
      Get.snackbar('Error', 'Failed to send message');
    }
  }

  void scrollToBottom() {
    // This would be implemented in the view to scroll chat list
  }

  // Send quick preset messages
  void sendQuickMessage(String messageType) {
    String content = "";
    
    switch (messageType) {
      case 'arrived':
        content = "I have arrived at your pickup location";
        break;
      case 'on_way':
        content = "I'm on my way to pick you up";
        break;
      case 'traffic':
        content = "Sorry, I'm running a bit late due to traffic";
        break;
      case 'call_me':
        content = "Please call me if you need to reach me";
        break;
    }
    
    if (content.isNotEmpty) {
      sendMessage(content);
    }
  }

  // Call customer from chat
  void callCustomer() {
    Get.back(); // Close chat
    // Implement call functionality
    Get.snackbar('Calling', 'Calling ${customerName.value}...');
  }

  @override
  void onClose() {
    _chatService.disconnect();
    super.onClose();
  }
}

