// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:taxi_driver/core/constants/app_colors.dart';
// import 'package:taxi_driver/core/constants/app_images.dart';
// import 'package:taxi_driver/core/widgets/primary_button.dart';
// import 'package:taxi_driver/features/driver/home/controller/home_controller.dart';
// import 'package:taxi_driver/routes/app_routes.dart';

// class HomeScreen extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,

//         leading: Padding(
//           padding: const EdgeInsets.only(left: 10.0),
//           child: CircleAvatar(
//             backgroundImage: AssetImage(AppImages.profile),
//             // backgroundColor: Colors.grey[300],
//           ),
//         ),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Lagos Nigeria',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Text(
//               'Good morning!',
//               style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Get.toNamed(AppRoutes.noti)
//             },
//             icon: Icon(Icons.notifications_outlined, color: Colors.black),
//           ),
//           IconButton(
//             onPressed: () => Get.toNamed(AppRoutes.chat),
//             icon: Container(
//               padding: EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryappcolor,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Icon(Icons.chat_outlined, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Driver Balance Card
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryappcolor,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Current balance',
//                       style: TextStyle(color: Colors.white, fontSize: 14.sp),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       controller.driverBalance.value,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${controller.todayBookings.value}',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Today Booking',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '₦${controller.todayEarnings.value.toStringAsFixed(0)}',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Today Earnings',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24.h),

//               //===============  Availability Toggle =============
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey[200]!),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Available',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             controller.isAvailable.value
//                                 ? 'You are online and can receive requests'
//                                 : 'You are offline',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Switch(
//                       value: controller.isAvailable.value,
//                       onChanged: (_) => controller.toggleAvailability(),
//                       activeColor: AppColors.primaryappcolor,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24),

//               // ================  Documents Status in furtue api ==================
//               if (!controller.documentsVerified.value) ...[
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.orange[50],
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.orange[200]!),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.description, color: Colors.orange[600]),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Documents under review',
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Text(
//                               'One document needs approval before you receive any request',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: controller.viewDocuments,
//                         child: Text('View all'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 24),
//               ],

//               // ================  No Request State (when no incoming requests) ========
//               if (!controller.hasIncomingRequest.value) ...[
//                 Center(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 40.h),
//                       Image.asset(
//                         AppImages.requestFound,
//                         width: 196,
//                         height: 190,
//                       ),
//                       SizedBox(height: 24),
//                       Text(
//                         controller.isAvailable.value
//                             ? 'NO REQUEST FOUND'
//                             : 'YOU ARE OFFLINE',
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         controller.isAvailable.value
//                             ? 'When you receive request, it will appear here'
//                             : 'Turn on availability to start receiving requests',
//                         style: TextStyle(
//                           color: Colors.grey[500],
//                           fontSize: 14.sp,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 32.h),

//                       if (controller.isAvailable.value)
//                         PrimaryButton(
//                           text: 'New Request',
//                           onTap: controller.createNewRequest,
//                         ),
//                       // if (controller.isAvailable.value)
//                       // ElevatedButton(
//                       //   onPressed: controller.createNewRequest,
//                       //   style: ElevatedButton.styleFrom(
//                       //     backgroundColor: Colors.red[600],
//                       //     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(8),
//                       //     ),
//                       //   ),
//                       //   child: Text(
//                       //     'New Request',
//                       //     style: TextStyle(color: Colors.white),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],

//               // Incoming Request Card
//               if (controller.hasIncomingRequest.value &&
//                   controller.currentRequest.value != null) ...[
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       // Customer Info
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 20,
//                             backgroundImage: NetworkImage(
//                               controller
//                                       .currentRequest
//                                       .value!
//                                       .customerAvatar
//                                       .isNotEmpty
//                                   ? controller
//                                         .currentRequest
//                                         .value!
//                                         .customerAvatar
//                                   : 'https://via.placeholder.com/40',
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   controller.currentRequest.value!.customerName,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 Text(
//                                   'New ride request',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Text(
//                             '₦${controller.currentRequest.value!.fareAmount.toStringAsFixed(0)}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: Colors.green[600],
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 16),

//                       // Pickup Location
//                       Row(
//                         children: [
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               controller.currentRequest.value!.pickupAddress,
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 8),

//                       // Destination Location
//                       Row(
//                         children: [
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               controller
//                                   .currentRequest
//                                   .value!
//                                   .destinationAddress,
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 16),

//                       // Accept/Decline Buttons
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: controller.declineRequest,
//                               style: OutlinedButton.styleFrom(
//                                 side: BorderSide(color: Colors.red[600]!),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12),
//                               ),
//                               child: Text(
//                                 'Decline',
//                                 style: TextStyle(color: Colors.red[600]),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () => controller.acceptRequest(
//                                 controller.currentRequest.value!,
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red[600],
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12),
//                               ),
//                               child: Text(
//                                 'Accept',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:taxi_driver/core/constants/app_colors.dart';
// import 'package:taxi_driver/core/constants/app_images.dart';
// import 'package:taxi_driver/core/widgets/custom_drawer.dart';
// import 'package:taxi_driver/core/widgets/primary_button.dart';
// import 'package:taxi_driver/features/driver/home/controller/home_controller.dart';
// import 'package:taxi_driver/routes/app_routes.dart';

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       drawer: CustomDrawer(),
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryappcolor,
//         foregroundColor: Colors.white,
//         title: Text('Transport App'),
//         actions: [
//           IconButton(
//             onPressed: () => Get.toNamed(AppRoutes.notification),
//             icon: Icon(Icons.notifications),
//           ),
//         ],
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ================= Top Ride Status =================
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryappcolor,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       controller.selectedRide.value,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Your Ride Status',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24),

//               // ================= Balance Section =================
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryappcolor,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Current balance',
//                         style: TextStyle(color: Colors.white, fontSize: 14.sp)),
//                     SizedBox(height: 8.h),
//                     Text(
//                       controller.driverBalance.value,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${controller.todayBookings.value}',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Today Booking',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '₦${controller.todayEarnings.value.toStringAsFixed(0)}',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Today Earnings',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24),

//               // ================= Quick Actions =================
//               Text(
//                 'Quick Actions',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 children: [
//                   _buildQuickActionCard(
//                     icon: Icons.account_balance_wallet,
//                     title: 'Wallet',
//                     subtitle: 'Check balance',
//                     color: Colors.blue,
//                     onTap: () => Get.toNamed(AppRoutes.wallet),
//                   ),
//                   _buildQuickActionCard(
//                     icon: Icons.history,
//                     title: 'History',
//                     subtitle: 'View trips',
//                     color: Colors.green,
//                     onTap: () => Get.toNamed(AppRoutes.history),
//                   ),
//                   _buildQuickActionCard(
//                     icon: Icons.star,
//                     title: 'Reviews',
//                     subtitle: 'Customer feedback',
//                     color: Colors.orange,
//                     onTap: () => Get.toNamed(AppRoutes.customerReviews),
//                   ),
//                   _buildQuickActionCard(
//                     icon: Icons.emergency,
//                     title: 'SOS',
//                     subtitle: 'Emergency help',
//                     color: Colors.red,
//                     onTap: () => Get.toNamed(AppRoutes.sos),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 24),

//               // ================= Availability Toggle =================
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey[200]!),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Available',
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w500)),
//                           Text(
//                             controller.isAvailable.value
//                                 ? 'You are online and can receive requests'
//                                 : 'You are offline',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Switch(
//                       value: controller.isAvailable.value,
//                       onChanged: (_) => controller.toggleAvailability(),
//                       activeColor: AppColors.primaryappcolor,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24),

//               // ================= No Request State =================
//               Center(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 40.h),
//                     Image.asset(AppImages.requestFound, width: 196, height: 190),
//                     SizedBox(height: 24),
//                     Text(
//                       controller.isAvailable.value
//                           ? 'NO REQUEST FOUND'
//                           : 'YOU ARE OFFLINE',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       controller.isAvailable.value
//                           ? 'When you receive request, it will appear here'
//                           : 'Turn on availability to start receiving requests',
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                         fontSize: 14.sp,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 32.h),
//                     PrimaryButton(
//                       text: 'New Request',
//                       onTap: controller.createNewRequest,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickActionCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: Icon(icon, color: color, size: 30),
//             ),
//             SizedBox(height: 12),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 4),
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[600],
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/constants/app_images.dart';
import 'package:taxi_driver/core/widgets/primary_button.dart';
import 'package:taxi_driver/features/driver/home/controller/home_controller.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(AppImages.profile),
            // backgroundColor: Colors.grey[300],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lagos Nigeria',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Good morning!',
              style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Get.toNamed(AppRoutes.noti)
            },
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.chat),
            icon: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryappcolor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.chat_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Driver Balance Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryappcolor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current balance',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      controller.driverBalance.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.todayBookings.value}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Today Booking',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₦${controller.todayEarnings.value.toStringAsFixed(0)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Today Earnings',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              //===============  Availability Toggle =============
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            controller.isAvailable.value
                                ? 'You are online and can receive requests'
                                : 'You are offline',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: controller.isAvailable.value,
                      onChanged: (_) => controller.toggleAvailability(),
                      activeColor: AppColors.primaryappcolor,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // ================  Documents Status - Always Show ==================
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.description, color: Colors.orange[600]),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Documents under review',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'One document needs approval before you receive any request',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: controller.viewDocuments,
                      child: Text('View all'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // ================  No Request State - Always Show ========
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Image.asset(
                      AppImages.requestFound,
                      width: 196,
                      height: 190,
                    ),
                    SizedBox(height: 24),
                    Text(
                      controller.isAvailable.value
                          ? 'NO REQUEST FOUND'
                          : 'YOU ARE OFFLINE',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      controller.isAvailable.value
                          ? 'When you receive request, it will appear here'
                          : 'Turn on availability to start receiving requests',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h),

                    PrimaryButton(
                      text: 'New Request',
                      onTap: controller.createNewRequest,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // ================  Always Show Request Card ==================
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Customer Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: (controller.currentRequest.value?.customerAvatar?.isNotEmpty ?? false)
                              ? NetworkImage(controller.currentRequest.value!.customerAvatar)
                              : AssetImage(AppImages.profile) as ImageProvider,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.currentRequest.value?.customerName ?? 'No request yet',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                controller.currentRequest.value != null
                                    ? 'New ride request'
                                    : 'Waiting for requests...',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          controller.currentRequest.value != null
                              ? '₦${controller.currentRequest.value!.fareAmount.toStringAsFixed(0)}'
                              : '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.green[600],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Pickup Location
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.currentRequest.value?.pickupAddress ?? 'No pickup location',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Destination Location
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.currentRequest.value?.destinationAddress ?? 'No destination',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Accept/Decline Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: controller.declineRequest,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primaryappcolor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'Decline',
                              style: TextStyle(color: Colors.red[600]),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.pickup);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryappcolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


