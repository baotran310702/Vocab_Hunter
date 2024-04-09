import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/utils/firebase_collections.dart';
import 'package:flutter/foundation.dart';

import 'user_hive_local.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> syncUserData() async {
    UserModel currentUser = await UserHiveLocal().getUser();

    try {
      QuerySnapshot snapshot = await _firestore
          .collection(AppCollections.user)
          .where('uid', isEqualTo: currentUser.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot doc = snapshot.docs.first;
        await doc.reference.update(currentUser.toMap());
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
