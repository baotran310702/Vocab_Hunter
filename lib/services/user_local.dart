import 'package:shared_preferences/shared_preferences.dart';

class UserLocal {
  late SharedPreferences _prefs;

  UserLocal() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  Future<void> saveUser(String email, String password) async {
    await _prefs.setString('email', email);
    await _prefs.setString('password', password);
  }

  Future<Map<String, String>> getUser() async {
    String email = _prefs.getString('email') ?? '';
    String password = _prefs.getString('password') ?? '';
    return {'email': email, 'password': password};
  }

  Future<void> removeUser() async {
    await _prefs.remove('email');
    await _prefs.remove('password');
  }

  Future<bool> isUser() async {
    String email = _prefs.getString('email') ?? '';
    String password = _prefs.getString('password') ?? '';
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  Future<String> getToken() async {
    return _prefs.getString('token') ?? '';
  }

  Future<void> removeToken() async {
    await _prefs.remove('token');
  }

  //save user id
  Future<void> saveUserId(String userId) async {
    await _prefs.setString('userId', userId);
  }

  //get user id
  Future<String> getUserId() async {
    return _prefs.getString('userId') ?? '';
  }
}
