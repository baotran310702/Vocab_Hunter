import 'package:dio/dio.dart';
import 'package:english_learner/models/news.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:flutter/foundation.dart';

class NewServices {
  NewServices._();

  static final NewServices instance = NewServices._();

  factory NewServices() {
    return instance;
  }

  Future<List<News>> getNews() async {
    String requestURL = "${APIPath.newsBaseURL}${APIKeys.newsAPIKey}";
    List<News> result = [];

    try {
      final response = await Dio().get(requestURL);
      if (response.statusCode == 200) {
        List<dynamic> listResponse = response.data["articles"];
        List<News> listNewsResult =
            listResponse.map((e) => News.fromJson(e)).toList();

        return List.generate(5, (index) => listNewsResult[index]);
      }
    } catch (e) {
      debugPrint("Exception is $e");
    }
    return result;
  }
}
