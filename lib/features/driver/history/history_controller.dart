// import 'package:get/get.dart';
// import 'package:taxi_driver/features/driver/data/models/history_model.dart';
// import 'package:taxi_driver/features/driver/data/services/api_service.dart';

// class HistoryController extends GetxController {
//   final ApiService _apiService = Get.find<ApiService>();
  
//   final RxList<HistoryModel> history = <HistoryModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString error = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadHistory();
//   }

//   Future<void> loadHistory() async {
//     try {
//       isLoading(true);
//       error('');
      
//       final historyList = await _apiService.getHistory();
//       history.assignAll(historyList);
//     } catch (e) {
//       error('Error: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
// }

import 'package:get/get.dart';

class HistoryModel {
  final String status; 
  final String from; 
  final String to; 
  final String price; 
  final String date; 
  final double rating; 

  HistoryModel({
    required this.status,
    required this.from,
    required this.to,
    required this.price,
    required this.date,
    required this.rating,
  });
}

class HistoryController extends GetxController {
  var historyList = <HistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() {
    historyList.value = [
      HistoryModel(
        status: "Completed",
        from: "Neemuch RD, Lagos, Nigeria",
        to: "RD. Gopalbari, Lagos",
        price: "₦5000",
        date: "02/05/2022",
        rating: 4.0,
      ),
      HistoryModel(
        status: "Cancel",
        from: "Neemuch RD, Gopalbari, Bari Sad",
        to: "Jawahar Lal Nehru Marg, D-Block",
        price: "₦5000",
        date: "08/05/2022",
        rating: 4.0,
      ),
    ];
  }
}

