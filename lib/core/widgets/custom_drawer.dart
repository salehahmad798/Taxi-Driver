import 'package:flutter/material.dart' hide DrawerController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/features/driver/home/controller/drawer_controller.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DrawerController>();

    return Drawer(
      child: Container(
        color: AppColors.primaryappcolor,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 10),
          
              //================== User Profile & Rating - get data reactively using Obx ========
              Obx(() {
                final user = controller.user.value;
                final profileImage = user.profileImage;
                final hasImage = profileImage != null && profileImage.isNotEmpty;
          
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: hasImage ? NetworkImage(profileImage!) : null,
                      child: hasImage ? null : const Icon(Icons.person, size: 30, color: AppColors.primaryappcolor),
                    ),
                     SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name ?? 'Frank Smith',
                          style:  TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children:  [
                            Text(
                              'Rating 4.8 ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xffFFC700),
                              size: 16.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }),
          
              const SizedBox(height: 30),
          
              //=============== Menu Options using controller navigation methods and your _buildMenuItem helper ===========
              _buildMenuItem(
                Icons.person_outline,
                "My Account",
                context,
                onTap: () {
                  // Navigator.of(context).pop();
                  controller.navigateToMyAccount();
                },
              ),
              _buildMenuItem(
                Icons.directions_car_outlined,
                "Update Vehicle Info",
                context,
                onTap: () {
                  // Navigator.of(context).pop();
                  controller.navigateToUpdateVehicle();
                },
              ),
              _buildMenuItem(
                Icons.attach_money_outlined,
                "Earnings",
                context,
                onTap: () {
              
                  controller.navigateToEarnings();
                },
              ),
              _buildMenuItem(
                Icons.folder_open_outlined,
                "Manage Documents",
                context,
                onTap: () {
              
                  controller.navigateToManageDocuments();
                },
              ),
              _buildMenuItem(
                Icons.help_outline,
                "FAQ",
                context,
                onTap: () {
              
                  controller.navigateToFAQ();
                },
              ),
              _buildMenuItem(
                Icons.star_outline,
                "Customer reviews",
                context,
                onTap: () {
              
                  controller.navigateToCustomerReviews();
                },
              ),
              _buildMenuItem(
                Icons.emergency_outlined,
                "SOS",
                context,
                onTap: () {
              
                  controller.navigateToSOS();
                },
              ),
              _buildMenuItem(
                Icons.notifications_outlined,
                "Notification",
                context,
                onTap: () {
              
                  controller.navigateToNotification();
                },
              ),
              _buildMenuItem(
                Icons.info_outline,
                "About",
                context,
                onTap: () {
              
                  controller.navigateToAbout();
                },
              ),
              _buildMenuItem(
                Icons.privacy_tip_outlined,
                "Privacy Policy",
                context,
                onTap: () {
              
                  controller.navigateToPrivacyPolicy();
                },
              ),
              _buildMenuItem(
                Icons.article_outlined,
                "Terms & Condition",
                context,
                onTap: () {
              
                  controller.navigateToTermsCondition();
                },
              ),
          
           
          
              // ============== Logout Button - call controller.logout method ===========
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryappcolor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                 
                    controller.logout();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
    
        if (onTap != null) {
          onTap();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Clicked $title')));
        }
      },
    );
  }
}
