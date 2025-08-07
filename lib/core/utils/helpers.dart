import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxi_driver/core/utils/app_toast.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd HH:mm'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatDateTime(String dateTime) {
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('yyyy-MM-dd hh:mm a').format(parsedDate);
    } catch (e) {
      return dateTime; // Return original string if parsing fails
    }
    //"2025-03-10 12:10 AM"
  }

  static String getFormattedDate(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat('EEEE, yyyy-MM-dd').format(dateTime);
  }

  static  String getFormattedTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat('hh:mm a').format(dateTime); // 12-hour format with AM/PM
  }

  static String generateRandomString(int length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  static Future<void> showAlertDialog(BuildContext context, String title, String message) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  
  static Future<bool> showConfirmationDialog(
      BuildContext context, String title, String message) async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                result = false;
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                result = true;
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
    return result;
  }

  
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }


  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+?1?\d{9,15}$');
    return phoneRegex.hasMatch(phone);
  }

  
  static void showSnackBar(BuildContext context, String message, {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: duration));
  }

  
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '')
        .join(' ');
  }

  
  static Color generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  /// Parse a hex color string to a [Color]
  static Color hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }



 // static  Future pickImage() async {
 //    final ImagePicker imagePicker = ImagePicker();
 //    var pickedImage = (await imagePicker.pickImage(source: ImageSource.camera))!;
 //
 //    return pickedImage;
 //  }
  static Future<XFile?> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();

    return await Get.bottomSheet<XFile?>(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text("Take Photo"),
              onTap: () async {
                final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
                Get.back(result: image); // close and return image
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.green),
              title: Text("Choose from Gallery"),
              onTap: () async {
                final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
                Get.back(result: image); // close and return image
              },
            ),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }




  void openGoogleMap(LatLng origin, LatLng destination) async {
    String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&travelmode=driving";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      AppToast.failToast("Google Maps not available, Please make sure you have a default Map app installed.");
      throw 'Could not open Google Maps.';
    }
  }

  void launchDialPad(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}