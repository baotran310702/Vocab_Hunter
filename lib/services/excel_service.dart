import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:english_learner/models/excel/ielts.dart';
import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/utils/firebase_collections.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class ExcelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Phương thức để đọc dữ liệu từ tệp Excel
  Future<List<List<dynamic>>?> readExcel() async {
    ByteData data = await rootBundle.load("assets/final_result_ielts.xlsx");
    var bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);
    List<List<dynamic>> result = [];

    if (excel.tables.keys.isNotEmpty) {
      var table = excel.tables[excel.tables.keys.first];
      for (int i = 0; i < table!.maxRows; i++) {
        result.add(table.row(i));
      }

      return [];
    }

    return [];
  }

  Future<List<IeltsVocab>> getIeltsVocab() async {
    ByteData data = await rootBundle.load("assets/final_result_ielts.xlsx");
    var bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);
    List<IeltsVocab> result = [];

    if (excel.tables.keys.isNotEmpty) {
      var table = excel.tables[excel.tables.keys.first];
      for (int i = 0; i < table!.maxRows; i++) {
        IeltsVocab newVocab = IeltsVocab(
            word: table.row(i)[0]?.value.toString() ?? "",
            meaning: table.row(i)[2]?.value.toString() ?? "",
            pronouce: table.row(i)[1]?.value.toString() ?? "",
            topic: table.row(i)[3]?.value.toString() ?? "");
        result.add(newVocab);
      }

      return result;
    }

    return [];
  }

  Future<List<VocabTopic>> getTopicVocab() async {
    ByteData data = await rootBundle.load("assets/final_result_topic.xlsx");
    var bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);
    List<VocabTopic> result = [];

    if (excel.tables.keys.isNotEmpty) {
      var table = excel.tables[excel.tables.keys.first];
      for (int i = 0; i < table!.maxRows; i++) {
        VocabTopic newVocab = VocabTopic(
          word: table.row(i)[1]?.value.toString() ?? "",
          meaning: table.row(i)[4]?.value.toString() ?? "",
          pronounce: table.row(i)[3]?.value.toString() ?? "",
          topic: table.row(i)[5]?.value.toString() ?? "",
          type: table.row(i)[2]?.value.toString() ?? "",
          exampleEnglish: '',
          exampleVietnamese: '',
        );
        result.add(newVocab);
      }

      return result;
    }

    return [];
  }

  Future<List<VocabTopic>> getVocabLocal() async {
    ByteData data = await rootBundle.load("assets/final_result_toeic.xlsx");
    var bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);
    List<VocabTopic> result = [];

    if (excel.tables.keys.isNotEmpty) {
      var table = excel.tables[excel.tables.keys.first];
      for (int i = 1; i < table!.maxRows; i++) {
        VocabTopic newVocab = VocabTopic(
          word: table.row(i)[1]?.value.toString() ?? "",
          meaning: table.row(i)[3]?.value.toString() ?? "",
          pronounce: "",
          topic: "",
          type: table.row(i)[2]?.value.toString() ?? "",
          exampleEnglish: table.row(i)[4]?.value.toString() ?? "",
          exampleVietnamese: table.row(i)[5]?.value.toString() ?? "",
        );
        result.add(newVocab);
      }
      print("start handling pronounce");

      await handlePronouceVocab(result);

      print("completed handling pronounce");

      return result;
    }

    return [];
  }

  Future<void> handlePronouceVocab(List<VocabTopic> listVocab) async {
    print("start handle pronounce");

    var pronounceList = await Future.wait(
        listVocab.map((e) => getVocabPronounce(e.word)).toList());

    print("completed handle pronounce");

    for (int i = 0; i < listVocab.length; i++) {
      listVocab[i].pronounce = pronounceList[i].toString();
    }
  }

  Future<String> getPronounceOnline(String word) async {
    var response = await Dio()
        .get('https://api.dictionaryapi.dev/api/v2/entries/en_US/$word');
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      VocabularyRemote englishVocabMeaning =
          VocabularyRemote.fromJson(jsonResponse[0]);
      return englishVocabMeaning.phonetic ?? "";
    } else {
      return "";
    }
  }

  Future<String> getVocabPronounce(String word) async {
    String jsonString = await rootBundle.loadString('assets/dictionary.json');

    var jsonResult = json.decode(jsonString) as List;

    print("checking for pronounce $word");

    List<dynamic> result = jsonResult;

    for (var item in result) {
      String itemString = item[1][0].toString();
      if (itemString.toLowerCase().trim() == word.toLowerCase().trim()) {
        return item[3][0].toString();
      }
    }

    return "";
  }

  Future<void> updateTopicVocabFirebase(
      Map<String, List<IeltsVocab>> map) async {
    List<Map<String, dynamic>> list = [];
    for (var entry in map.entries) {
      await _firestore
          .collection(AppCollections.vocabTopic)
          .doc(AppDocument.ielts)
          .collection(AppCollections.topicVocab)
          .add({
        'topic': entry.key,
        'vocab': entry.value.map((e) => e.toJson()).toList()
      });
    }

    print("update completed");
  }

  Future<void> updateTopicVocabFbByTopicNotIelts(
      Map<String, List<VocabTopic>> map) async {
    List<Map<String, dynamic>> list = [];
    for (var entry in map.entries) {
      await _firestore
          .collection(AppCollections.vocabTopic)
          .doc(AppDocument.topic)
          .collection(AppCollections.topicVocab)
          .add({
        'topic': entry.key,
        'vocab': entry.value.map((e) => e.toMap()).toList()
      });
    }

    print("update completed");
  }

  Future<void> updateToeicVocabFirebase(List<VocabTopic> list) async {
    print("start update firebase");
    int numChunk = 30;
    // Tính toán kích thước của mỗi mảng con
    int chunkSize = (list.length / numChunk).ceil();

    List<List<VocabTopic>> chunks = [];

    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }

    for (int i = 0; i < chunks.length; i++) {
      await _firestore
          .collection(AppCollections.vocabTopic)
          .doc(AppDocument.toeic)
          .collection(AppCollections.topicVocab)
          .add(
        {
          'topic': 'part $i',
          'vocab': chunks[i].map((e) => e.toMap()).toList(),
        },
      );
    }
  }
}
