import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/models/vocabulary_topic/list_vocabulary_topic.dart';
import 'package:english_learner/models/vocabulary_topic/vocabulary_topic.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:english_learner/utils/firebase_collections.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/sub_topic.dart';

class TopicVocabServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TopicVocabServices._();

  static final TopicVocabServices instance = TopicVocabServices._();

  factory TopicVocabServices() {
    return instance;
  }

  ///Handle cache local here
  ///Get List Vocabulary Topic from Local
  Future<List<ListVocabularyTopic>> getListVocabTopicLocal() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveTopicVocabLocal)) {
      Hive.registerAdapter(VocabularyByTopicAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListTopicVocabLocal)) {
      Hive.registerAdapter(ListVocabularyTopicAdapter());
    }

    final topicVocabBox = await Hive.openBox<ListVocabularyTopic>(
        KeyBoxHiveLocal.listVocabTopicLocal);
    return topicVocabBox.values.toList();
  }

  ///Handle cache sub topic with vocabulary local
  ///Save ListVocabulary Topic to local
  Future<void> saveListVocabularyTopicLocal(
      List<ListVocabularyTopic> listSubtopics) async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveTopicVocabLocal)) {
      Hive.registerAdapter(VocabularyByTopicAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListTopicVocabLocal)) {
      Hive.registerAdapter(ListVocabularyTopicAdapter());
    }

    final topicVocabBox = await Hive.openBox<ListVocabularyTopic>(
        KeyBoxHiveLocal.listVocabTopicLocal);
    for (ListVocabularyTopic vocab in listSubtopics) {
      await topicVocabBox.add(vocab);
    }
  }

  Future<void> saveAListVocabularyTopicLocal(
      ListVocabularyTopic subTopics) async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveTopicVocabLocal)) {
      Hive.registerAdapter(VocabularyByTopicAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListTopicVocabLocal)) {
      Hive.registerAdapter(ListVocabularyTopicAdapter());
    }

    final topicVocabBox = await Hive.openBox<ListVocabularyTopic>(
        KeyBoxHiveLocal.listVocabTopicLocal);
    await topicVocabBox.add(subTopics);
  }

  Future<void> updateAmountWordsTopic(String docId, Topic topic) async {
    await _firestore.collection(AppCollections.vocabTopic).doc(docId).set(
          topic.toJson(),
        );
  }

  Future<ListVocabularyTopic> getOneListTopicVocabularyTopic(
      String topicId, String subTopicId) async {
    try {
      final snapshot = await _firestore
          .collection(AppCollections.vocabTopic)
          .doc(topicId.toLowerCase())
          .collection(AppCollections.topicVocab)
          .where('topic', isEqualTo: subTopicId)
          .get();
      return ListVocabularyTopic.fromJson(snapshot.docs.first.data());
    } catch (e) {
      debugPrint(e.toString());
      return ListVocabularyTopic.empty();
    }
  }

  Future<List<ListVocabularyTopic>> getListVocabularyTopic(String docId) async {
    List<ListVocabularyTopic> listVocabularyTopic = [];

    try {
      final snapshot = await _firestore
          .collection(AppCollections.vocabTopic)
          .doc(docId)
          .collection(AppCollections.topicVocab)
          .get();

      for (var doc in snapshot.docs) {
        listVocabularyTopic.add(ListVocabularyTopic.fromJson(doc.data()));
      }
      return listVocabularyTopic;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<ListVocabularyTopic> getSubTopic(
      String docId, String subTopicId) async {
    try {
      final snapshot = await _firestore
          .collection(AppCollections.vocabTopic)
          .doc(docId)
          .collection(AppCollections.topicVocab)
          .where('topic', isEqualTo: subTopicId)
          .get();

      return ListVocabularyTopic.fromJson(snapshot.docs[0].data());
    } catch (e) {
      debugPrint(e.toString());
      return ListVocabularyTopic.empty();
    }
  }

  Future<List<SubTopic>> getListTopicByName(String topicId) async {
    List<SubTopic> subTopics = [];

    var querySnapshop = await _firestore
        .collection(AppCollections.vocabTopic)
        .doc(topicId)
        .collection(AppCollections.topicVocab)
        .get();

    for (var item in querySnapshop.docs) {
      SubTopic subTopic = SubTopic.fromJson(item.data());
      print(subTopic.toJson());
    }

    return subTopics;
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
