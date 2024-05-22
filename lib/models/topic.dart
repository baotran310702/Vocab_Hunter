//write class topic with data type is topicId, name, image, description, topicStatus with all them is required params and final

import 'package:english_learner/models/sub_topic.dart';
import 'package:equatable/equatable.dart';

class Topic extends Equatable {
  final String topicId;
  final String name;
  final String image;
  final String description;
  final List<SubTopic> subTopics;

  const Topic({
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
      image: json['image'] ?? " ",
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

  @override
  List<Object?> get props => [
        topicId,
        name,
        image,
        description,
        subTopics,
      ];
}
