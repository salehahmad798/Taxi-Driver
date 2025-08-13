import 'package:get/get.dart';
import 'customer_reviews_controller.dart';

class CustomerReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerReviewsController>(() => CustomerReviewsController());
  }
}
