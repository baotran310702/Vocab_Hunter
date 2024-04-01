import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/services/user_pref_local.dart';
import 'package:english_learner/utils/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<(bool, String)> signUp(
      String email, String password, String userName) async {
    try {
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = result.user?.uid ?? "";
      var response = await _firestore.collection(AppCollections.user).add(
            UserModel.initWithId(uid, userName).toMap(),
          );
      return (true, response.id);
    } catch (e) {
      String err = e.toString().split("]")[1].trim();
      return (false, err);
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result.user!.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    UserNormalInformationLocal().removeUserId();
    await FirebaseAuth.instance.signOut();
  }
}
