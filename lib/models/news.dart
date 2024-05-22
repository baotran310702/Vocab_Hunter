import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String title;
  final String coverImage;
  final String content;

  const News({
    required this.title,
    required this.coverImage,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      coverImage: json['coverImage'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'coverImage': coverImage,
      'content': content,
    };
  }

  @override
  List<Object?> get props => [title, coverImage, content];
}
