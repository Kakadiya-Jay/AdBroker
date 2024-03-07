import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userContactKey = "USERCONTACTKEY";
  static String userRoleKey = "USERROLLKEY";
  static String userImageUrlKey = "USERIMAGEURLKEY";

  // saving the data to SF

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(
        userLoggedInKey, isUserLoggedIn); // {"userLoggedInKey": true,}
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveUserContactSF(String userContact) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userContactKey, userContact);
  }

  static Future<bool> saveUserRoleSF(String userRole) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userRoleKey, userRole);
  }

  static Future<bool> saveUserImageURLSF(String imageUrl) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userImageUrlKey, imageUrl);
  }

  // getting the data from SF

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserContactFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userContactKey);
  }

  static Future<String?> getUserRoleFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userRoleKey);
  }

  static Future<String?> getUserImageUrlSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userImageUrlKey);
  }
}
