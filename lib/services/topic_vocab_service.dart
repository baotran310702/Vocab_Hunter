import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/utils/firebase_collections.dart';
import 'package:flutter/material.dart';

import '../models/sub_topic.dart';

class TopicVocabServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TopicVocabServices._();

  static final TopicVocabServices instance = TopicVocabServices._();

  factory TopicVocabServices() {
    return instance;
  }

  Future<List<Topic>> getAllTopicVocab() async {
    List<Topic> listTopicVocab = [];

    try {
      final snapshot =
          await _firestore.collection(AppCollections.vocabTopic).get();

      for (var doc in snapshot.docs) {
        listTopicVocab.add(Topic.fromJson(doc.id, doc.data()));
      }
      return listTopicVocab;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<void> updateSubTopicVocab(
      List<SubTopic> listSubTopic, String topicId) async {
    try {
      final snapshot =
          await _firestore.collection(AppCollections.vocabTopic).get();
      for (var doc in snapshot.docs) {
        if (doc.id.toString() == topicId.toString()) {
          await _firestore
              .collection(AppCollections.vocabTopic)
              .doc(doc.id)
              .update(
            {
              "subTopic": listSubTopic.map((e) => e.toJson()).toList(),
            },
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
