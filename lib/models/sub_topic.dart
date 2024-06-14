// ignore_for_file: must_be_immutable

import 'package:english_learner/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'sub_topic.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveSubTopicLocal)
class SubTopic extends Equatable {
  @HiveField(0)
  String subTopicId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  String description;
  @HiveField(4)
  int amountVocab;

  SubTopic({
    required this.name,
    required this.image,
    required this.description,
    required this.subTopicId,
    required this.amountVocab,
  });

  factory SubTopic.initial() {
    return SubTopic(
        name: "", image: "", description: "", subTopicId: "", amountVocab: -1);
  }

  factory SubTopic.fromJson(Map<String, dynamic> json) {
    return SubTopic(
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      description: json['description'] ?? "",
      subTopicId: json['subTopicId'] ?? "",
      amountVocab: json['amountVocab'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'subTopicId': subTopicId,
      'amountVocab': amountVocab,
    };
  }

  @override
  List<Object?> get props =>
      [name, image, description, subTopicId, amountVocab];
}
