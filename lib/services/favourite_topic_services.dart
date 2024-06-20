import 'package:english_learner/models/favourite_topic.dart';
import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class FavouriteTopicLocal {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);
  }

  Future<void> addFavouriteTopic(SubTopic topic) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveFavouriteTopics)) {
      Hive.registerAdapter(ListFavouriteTopicAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveSubTopicLocal)) {
      Hive.registerAdapter(SubTopicAdapter());
    }
    final box =
        await Hive.openBox<ListFavouriteTopic>(KeyBoxHiveLocal.favouriteTopic);

    ListFavouriteTopic listFavouriteTopic =
        box.get(KeyBoxHiveLocal.favouriteTopic) ?? ListFavouriteTopic.empty();

    List<SubTopic> currentTopic = [
      ...List.from(listFavouriteTopic.favouriteTopics),
      topic
    ];

    ListFavouriteTopic newListTopic =
        ListFavouriteTopic(favouriteTopics: currentTopic);

    await box.put(KeyBoxHiveLocal.favouriteTopic, newListTopic);
  }

  Future<List<SubTopic>> getFavouriteTopic() async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveFavouriteTopics)) {
      Hive.registerAdapter(ListFavouriteTopicAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveSubTopicLocal)) {
      Hive.registerAdapter(SubTopicAdapter());
    }
    final box =
        await Hive.openBox<ListFavouriteTopic>(KeyBoxHiveLocal.favouriteTopic);

    ListFavouriteTopic currentListFavouriteTopic =
        box.get(KeyBoxHiveLocal.favouriteTopic) ?? ListFavouriteTopic.empty();
    await box.close();

    return currentListFavouriteTopic.favouriteTopics;
  }

  Future<void> updateListFavouriteTopic(List<SubTopic> newList) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveFavouriteTopics)) {
      Hive.registerAdapter(ListFavouriteTopicAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveSubTopicLocal)) {
      Hive.registerAdapter(SubTopicAdapter());
    }
    final box =
        await Hive.openBox<ListFavouriteTopic>(KeyBoxHiveLocal.favouriteTopic);
    await box.clear();
    await box.put(KeyBoxHiveLocal.favouriteTopic,
        ListFavouriteTopic(favouriteTopics: newList));
  }

  Future<void> removeAFavouriteTopic(String id) async {
    List<SubTopic> currentTopic = await getFavouriteTopic();
    List<SubTopic> newList = currentTopic
        .where((element) =>
            element.name.trim().toLowerCase() != id.trim().toLowerCase())
        .toList();
    ListFavouriteTopic newListFavouriteTopic =
        ListFavouriteTopic(favouriteTopics: newList);

    final box = await Hive.openBox(KeyBoxHiveLocal.favouriteTopic);

    await box.clear();
    await box.put(KeyBoxHiveLocal.favouriteTopic, newListFavouriteTopic);
  }
}
