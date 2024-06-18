//write class topic with data type is topicId, name, image, description, topicStatus with all them is required params and final

// ignore_for_file: must_be_immutable

import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'topic.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveTopicCacheLocal)
class Topic extends Equatable {
  @HiveField(0)
  String topicId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  String description;
  @HiveField(4)
  List<SubTopic> subTopics;

  Topic({
    required this.topicId,
    required this.name,
    required this.image,
    required this.description,
    required this.subTopics,
  });

  factory Topic.fromJson(String id, Map<String, dynamic> json) {
    return Topic(
      topicId: id,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      description: json['description'] ?? "",
      subTopics: json['subTopic'] == null
          ? []
          : (json['subTopic'] as List)
              .map((e) => SubTopic.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'subTopic': subTopics.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Topic{topicId: $topicId, name: $name, image: $image, description: $description}';
  }

  Topic copyWith({
    String? topicId,
    String? name,
    String? image,
    String? description,
    List<SubTopic>? subTopics,
  }) {
    return Topic(
      topicId: topicId ?? this.topicId,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      subTopics: subTopics ?? this.subTopics,
    );
  }

  @override
  List<Object?> get props => [
        topicId,
        name,
        image,
        description,
        subTopics,
      ];
}
