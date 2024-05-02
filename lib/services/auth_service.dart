import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:english_learner/services/user_pref_local.dart';
import 'package:english_learner/utils/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
      String uid = result.user?.uid ?? "";
      String token = await result.user?.getIdToken() ?? "";
      var response = await _firestore
          .collection(AppCollections.user)
          .where("uid", isEqualTo: uid)
          .get();
      //update token firebase
      await _firestore
          .collection(AppCollections.userAuth)
          .add({"uid": uid, "token": token});
      await UserHiveLocal()
          .saveUser(UserModel.fromMap(response.docs.first.data(), uid));
      await UserPrefererencesLocal().saveToken(token);
      return uid;
    } catch (e) {
      debugPrint("login fail with error: $e");
      throw Exception(e);
    }
  }

  Future<bool> signInWithToken(String token) async {
    try {
      var response = await _firestore
          .collection(AppCollections.userAuth)
          .where("token", isEqualTo: token)
          .get();
      if (response.docs.isEmpty) {
        return false;
      }
      var userRes = await _firestore
          .collection(AppCollections.user)
          .where("uid", isEqualTo: response.docs.first.data()["uid"].toString())
          .get();
      UserModel currentUser = await UserHiveLocal().getUser();

      if (currentUser.uid == userRes.docs.first.data()["uid"].toString()) {
        return true;
      }

      await UserHiveLocal().saveUser(
        UserModel.fromMap(
          userRes.docs.first.data(),
          userRes.docs.first.data()['uid'].toString(),
        ),
      );
      if (userRes.docs.first.id.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("reson for not working good with token:$e");
      return false;
    }
  }

  Future<void> signOut() async {
    UserPrefererencesLocal().removeUserId();
    await UserPrefererencesLocal().removeToken();
    await UserHiveLocal().removeUser();
    await FirebaseAuth.instance.signOut();
  }
}
