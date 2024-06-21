import 'package:english_learner/models/news.dart';
import 'package:english_learner/services/news_service.dart';

class NewsRepository {
  late NewServices newServices;
  NewsRepository() {
    newServices = NewServices.instance;
  }

  Future<List<News>> getNews() async {
    return await newServices.getNews();
  }
}
