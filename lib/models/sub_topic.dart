// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class SubTopic extends Equatable {
  String subTopicId;
  String name;
  String image;
  String description;

  SubTopic(
      {required this.name,
      required this.image,
      required this.description,
      required this.subTopicId});

  factory SubTopic.fromJson(Map<String, dynamic> json) {
    return SubTopic(
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      description: json['description'] ?? "",
      subTopicId: json['subTopicId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'subTopicId': subTopicId,
    };
  }

  @override
  List<Object?> get props => [name, image, description, subTopicId];
}
