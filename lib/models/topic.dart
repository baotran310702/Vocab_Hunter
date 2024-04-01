//write class topic with data type is topicId, topicName, topicImage, topicDescription, topicStatus with all them is required params and final

import 'package:equatable/equatable.dart';

class Topic extends Equatable {
  final String topicId;
  final String topicName;
  final String topicImage;
  final String topicDescription;
  final String topicStatus;

  const Topic({
    required this.topicId,
    required this.topicName,
    required this.topicImage,
    required this.topicDescription,
    required this.topicStatus,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: json['topicId'],
      topicName: json['topicName'],
      topicImage: json['topicImage'],
      topicDescription: json['topicDescription'],
      topicStatus: json['topicStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'topicName': topicName,
      'topicImage': topicImage,
      'topicDescription': topicDescription,
      'topicStatus': topicStatus,
    };
  }

  @override
  String toString() {
    return 'Topic{topicId: $topicId, topicName: $topicName, topicImage: $topicImage, topicDescription: $topicDescription, topicStatus: $topicStatus}';
  }

  @override
  List<Object?> get props =>
      [topicId, topicName, topicImage, topicDescription, topicStatus];
}
