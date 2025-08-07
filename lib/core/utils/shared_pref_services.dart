import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class SharePrefServices {
  static saveLoggInUserIsGenral(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('saveLoggInUserIsGenral', val);
  }

  static getLoggInUserIsGenral() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('saveLoggInUserIsGenral');
  }

  static saveAuthToken(String val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('authToken', val);
  }

  static getAuthToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('authToken');
  }

  static saveUserData(data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userData', data);
  }

  static saveServiceProviderUserData(data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('serviceProviderUserDetail', data);
  }

  static getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userRaw = pref.getString("userData");
    if (userRaw != null) {
      try {
        Map<String, dynamic> userJson = jsonDecode(userRaw);
        // return GeneralUserModel.fromJson(userJson);
      } catch (e) {
        print("Error decoding user data: $e"); 
        return null;
      }
    }
    else {
      return null;
    }
  }

   static getServiceProviderUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userRaw = pref.getString("serviceProviderUserDetail");

    if (userRaw != null) {
      try {
        Map<String, dynamic> userJson = jsonDecode(userRaw);
        // return ServiceProviderUserModel.fromJson(userJson);
      } catch (e) {
        print("Error decoding user data: $e");
        return null;
      }
    }
    return null;
  }
}