import 'package:english_learner/models/favourite_topic.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class FavouriteTopicLocal {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveFavouriteTopics)) {
      Hive.registerAdapter(ListFavouriteTopicAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveTopicCacheLocal)) {
      Hive.registerAdapter(TopicAdapter());
    }
  }

  Future<void> addFavouriteTopic(Topic topic) async {
    final box =
        await Hive.openBox<ListFavouriteTopic>(KeyBoxHiveLocal.favouriteTopic);

    ListFavouriteTopic listFavouriteTopic =
        box.get(KeyBoxHiveLocal.favouriteTopic) ?? ListFavouriteTopic.empty();

    List<Topic> currentTopic = listFavouriteTopic.favouriteTopics;

    currentTopic.add(topic);

    ListFavouriteTopic newListTopic =
        ListFavouriteTopic(favouriteTopics: currentTopic);

    await box.clear();
    await box.add(newListTopic);
  }

  Future<List<Topic>> getFavouriteTopic() async {
    final box =
        await Hive.openBox<ListFavouriteTopic>(KeyBoxHiveLocal.favouriteTopic);

    ListFavouriteTopic currentListFavouriteTopic =
        box.get(KeyBoxHiveLocal.favouriteTopic) ?? ListFavouriteTopic.empty();

    return currentListFavouriteTopic.favouriteTopics;
  }

  Future<void> removeAFavouriteTopic(String id) async {
    List<Topic> currentTopic = await getFavouriteTopic();
    List<Topic> newList =
        currentTopic.where((element) => element.topicId != id).toList();
    ListFavouriteTopic newListFavouriteTopic =
        ListFavouriteTopic(favouriteTopics: newList);

    final box = await Hive.openBox(KeyBoxHiveLocal.favouriteTopic);

    box.clear();
    await box.add(newListFavouriteTopic);
  }
}
