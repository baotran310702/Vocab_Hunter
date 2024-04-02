import 'package:english_learner/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNormalInformationLocal {
  /// The  [saveUserId]  method retrieves the user ID from the local storage.
  /// Create a new file named  user_service.dart  in the  lib/services  directory.
  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KeyLocalPreferences.userId, userId);
  }

  /// The  [getUserId]  method retrieves the user ID from the local storage.
  /// Create a new file named  user_service.dart  in the  lib/services  directory.
  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyLocalPreferences.userId) ?? '';
  }

  /// The  [removeUserId]  method removes the user ID from the local storage.
  Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(KeyLocalPreferences.userId);
  }

  /// Save token when user login to local
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KeyLocalPreferences.token, token);
  }

  /// Get token when user login to local
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyLocalPreferences.token) ?? '';
  }
}
