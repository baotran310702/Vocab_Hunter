import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/utils/firebase_collections.dart';
import 'package:flutter/material.dart';

import 'user_hive_local.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> streamNotificationApp() {
    Stream<QuerySnapshot> snapshots = _firestore
        .collection(AppCollections.notification)
        .orderBy('time', descending: true)
        .snapshots();

    return snapshots;
  }

  Future<void> updateUserLocal(UserModel user) async {
    await UserHiveLocal().saveUser(user);
  }

  Future<void> syncUserData() async {
    UserModel currentUser = await UserHiveLocal().getUser();

    try {
      QuerySnapshot snapshot = await _firestore
          .collection(AppCollections.user)
          .where('uid', isEqualTo: currentUser.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await _firestore
            .collection(AppCollections.user)
            .doc(snapshot.docs.first.id)
            .update(currentUser.toMap());
      } else {
        debugPrint('User not found');
      }
    } catch (e) {
      if (e is FirebaseException) {
        switch (e.code) {
          case 'permission-denied':
            debugPrint(
                'Permission denied. Make sure you have permission to access the resource.');
            break;
          case 'aborted':
            debugPrint(
                'The operation was aborted, typically due to a concurrency issue.');
            break;
          default:
            debugPrint('Firebase error: ${e.code}');
        }
      } else {
        debugPrint('Error: $e');
      }
    }
  }
}
