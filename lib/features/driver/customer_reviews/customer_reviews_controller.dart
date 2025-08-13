// import 'package:get/get.dart';
// import 'package:taxi_driver/features/driver/data/models/review_model.dart';
// import 'package:taxi_driver/features/driver/data/services/api_service.dart';

// class CustomerReviewsController extends GetxController {
//   final ApiService _apiService = Get.find<ApiService>();
  
//   final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString error = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadReviews();
//   }

//   Future<void> loadReviews() async {
//     try {
//       isLoading(true);
//       error('');
      
//       final reviewList = await _apiService.getCustomerReviews();
      
//       // Update list
//       reviews.assignAll(reviewList);
//     } catch (e) {
//       error('Failed to load reviews: $e');
//       reviews.clear();
//     } finally {
//       isLoading(false);
//     }
//   }
// }



import 'package:get/get.dart';

class ReviewModel {
  final String name;
  final String date;
  final double rating;
  final String title;
  final String comment;

  ReviewModel({
    required this.name,
    required this.date,
    required this.rating,
    required this.title,
    required this.comment,
  });
}

class CustomerReviewsController extends GetxController {
  var reviews = <ReviewModel>[
    ReviewModel(
      name: "Sophia Carter",
      date: "Mar 12, 2024",
      rating: 5.0,
      title: "Amazing Experience!",
      comment:
          "The taxi driver was punctual, polite, and drove safely. A smooth and pleasant ride overall!",
    ),
    ReviewModel(
      name: "Sophia Carter",
      date: "Mar 12, 2024",
      rating: 5.0,
      title: "Amazing Experience!",
      comment:
          "The taxi driver was punctual, polite, and drove safely. A smooth and pleasant ride overall!",
    ),
    ReviewModel(
      name: "Sophia Carter",
      date: "Mar 12, 2024",
      rating: 5.0,
      title: "Amazing Experience!",
      comment:
          "The taxi driver was punctual, polite, and drove safely. A smooth and pleasant ride overall!",
    ),
  ].obs;
}
