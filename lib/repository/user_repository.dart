import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/services/auth_service.dart';
import 'package:english_learner/services/user_service.dart';

class UserRepository {
  late AuthenticationServices authenServices;
  late UserServices userServices;

  UserRepository() {
    authenServices = AuthenticationServices();
    userServices = UserServices();
  }

  Future<(bool, String)> signUp(
      String email, String password, String userName) async {
    return await authenServices.signUp(email, password, userName);
  }

  Future<String> signIn(String email, String password) async {
    return await authenServices.signIn(email, password);
  }

  Future<bool> signInWithToken(String token) async {
    return await authenServices.signInWithToken(token);
  }

  Future<void> signOut() async {
    await authenServices.signOut();
  }

  Future<void> changePassword(String newPassword) async {
    await authenServices.changePassword(newPassword);
  }

  Future<void> syncUserData() async {
    await userServices.syncUserData();
  }

  Future<void> updateUserLocal(UserModel user) async {
    await UserServices().updateUserLocal(user);
  }

  Stream<QuerySnapshot> streamNotificationApp() {
    return userServices.streamNotificationApp();
  }
}
