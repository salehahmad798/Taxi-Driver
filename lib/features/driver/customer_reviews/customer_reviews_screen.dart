import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/custom_appbar.dart';
import 'customer_reviews_controller.dart';

class CustomerReviewsScreen extends GetView<CustomerReviewsController> {
  const CustomerReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: CustomAppBar(text: 'Customer reviews'),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.reviews.length,
          itemBuilder: (context, index) {
            final review = controller.reviews[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.kprimaryColor,
                        child: Text(
                          review.name[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                       SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name,
                            style:  TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                          Text(
                            "on ${review.date}",
                            style:  TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      review.rating.toInt(),
                      (i) => const Icon(Icons.star,
                          color: Color(0xffFFC107), size: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(review.comment),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
