import 'package:english_learner/services/auth_service.dart';

class UserRepository {
  late AuthenticationServices authenServices;

  UserRepository() {
    authenServices = AuthenticationServices();
  }

  Future<(bool, String)> signUp(
      String email, String password, String userName) async {
    return await authenServices.signUp(email, password, userName);
  }

  Future<String> signIn(String email, String password) async {
    return await authenServices.signIn(email, password);
  }

  Future<bool> signInWithToken() async {
    return await authenServices.signInWithToken();
  }

  Future<void> signOut() async {
    await authenServices.signOut();
  }
}
