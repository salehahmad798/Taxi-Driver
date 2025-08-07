import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/widgets/primary_button.dart';
import 'package:taxi_driver/routes/app_routes.dart';
import 'package:get/route_manager.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomDrawer({required this.onLogout, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.primaryappcolor,
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 28,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(height: 10),

            // Profile Picture & Name with Rating
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=3',
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mira Vaccaro',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Rating 4.8 ',
                          style: TextStyle(color: AppColors.kwhite),
                        ),
                        Icon(Icons.star, color: Color(0xffFFC700), size: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 30),

            // Menu Options
            _buildMenuItem(
              Icons.home_outlined,
              "Home",
              context,
              onTap: () {
              // Get.toNamed(AppRoutes.pickUp);
          
              },
            ),
            _buildMenuItem(Icons.help_outline, "Help", context,
            onTap: () {
              // Get.toNamed(AppRoutes.report);
            },
            ),
            _buildMenuItem(
              Icons.campaign_outlined,
              "Activities",
              context,
              onTap: () {
                // Get.toNamed(AppRoutes.activities);
              },
            ),
            _buildMenuItem(
              Icons.settings_outlined,
              "Profile",
              context,

              onTap: () {
                // Get.toNamed(AppRoutes.profile);
              },
            ),
            _buildMenuItem(
              Icons.person_add_alt_outlined,
              "Invite friends",
              context,
              onTap: () {
                // Get.toNamed(AppRoutes.inviteFriend);
              },
            ),
            _buildMenuItem(
              Icons.chat_bubble_outline,
              "Chat support",
              context,
              onTap: () {
                // Get.toNamed(AppRoutes.supportChat);
              },
            ),

            Spacer(),

            // Logout Button
            PrimaryIconButton(
              text: 'Logout',
              color: AppColors.kwhite,
              tcolor: AppColors.kprimaryColor,
              iconEnable: true,

              onTap: onLogout,
              textSize: 16.sp,
              icon: Icons.logout_rounded,
              iconColor: AppColors.kprimaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    BuildContext context, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: () {
        Navigator.of(context).pop(); // Close drawer after selection
        if (onTap != null) {
          onTap();
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Clicked $title')));
        }
      },
    );
  }
}
