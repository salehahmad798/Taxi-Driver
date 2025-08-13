import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:taxi_driver/features/driver/my_account/my_account_controller.dart';

class MyAccountScreen extends GetView<MyAccountController> {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Account'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement more actions
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.user.value.name == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty && controller.user.value.name == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.error.value),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.loadUserProfile(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadUserProfile,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // User Profile Section
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[200],
                            child: controller.user.value.profileImage != null
                                ? ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: controller.user.value.profileImage!,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                          ),
                          if (controller.isLoading.value)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.user.value.name ?? 'Frank Smith',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              controller.user.value.phone ?? '+234 1234567891',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: controller.navigateToEditProfile,
                        icon: Icon(Icons.edit, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                
                Divider(),
                
                // Bank Account & Cards Section
                _buildSectionHeader('BANK ACCOUNT & CARDS'),
                _buildBankCardsList(),
                _buildAddBankAccountButton(),
                
                Divider(),
                
                // Quick Links Section
                _buildSectionHeader('QUICK LINKS'),
                _buildQuickLink(
                  'History', 
                  Icons.history, 
                  controller.navigateToHistory,
                ),
                _buildQuickLink(
                  'Wallet', 
                  Icons.account_balance_wallet, 
                  controller.navigateToWallet,
                ),
                
                SizedBox(height: 20),
                
                // Delete Account Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: controller.deleteAccount,
                    child: Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                
                // Logout Button
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildBankCardsList() {
    return Obx(() {
      final bankCards = controller.user.value.bankCards ?? [];
      
      if (bankCards.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'No bank cards added yet',
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      }
      
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: bankCards.length,
        itemBuilder: (context, index) {
          final card = bankCards[index];
          return ListTile(
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.account_balance,
                color: Colors.red[700],
              ),
            ),
            title: Text(
              card.bankName ?? 'Bank of Nigeria',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              '****${card.accountNumber?.substring(card.accountNumber!.length - 4) ?? '1234'}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                card.cardType ?? 'Debit',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildAddBankAccountButton() {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.red[700],
        ),
      ),
      title: Text(
        'ADD BANK ACCOUNT',
        style: TextStyle(
          color: Colors.red[700],
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Get.snackbar('Info', 'Add bank account feature coming soon');
      },
    );
  }

  Widget _buildQuickLink(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.grey[700]),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      onTap: onTap,
    );
  }
}
