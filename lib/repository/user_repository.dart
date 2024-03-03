import 'package:english_learner/services/user_services.dart';

class UserRepository {
  late UserServices userService;

  UserRepository() {
    userService = UserServices();
  }

  Future<void> signUp(String email, String password) async {
    await userService.signUp(email, password);
  }

  Future<void> signIn(String email, String password) async {
    await userService.signIn(email, password);
  }

  Future<void> signOut() async {
    await userService.signOut();
  }
}
