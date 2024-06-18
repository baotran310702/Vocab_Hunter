import 'package:english_learner/models/topic.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

part 'favourite_topic.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveFavouriteTopics)
class ListFavouriteTopic {
  @HiveField(0)
  final List<Topic> favouriteTopics;

  factory ListFavouriteTopic.empty() {
    return const ListFavouriteTopic(favouriteTopics: []);
  }

  const ListFavouriteTopic({required this.favouriteTopics});
}
