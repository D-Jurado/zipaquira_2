import 'package:zipaquira_2/domain/entities/news_post.dart';

class LocalNewsModel {
  final String type;
  final String title;
  final String imageUrl;
  final String city;
  final String date;

  LocalNewsModel(
      {required this.type,
      required this.title,
      required this.imageUrl,
      required this.city,
      required this.date});

  factory LocalNewsModel.fromJson(Map<String, dynamic> json) => LocalNewsModel(
        type: json['type'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        city: json['city'],
        date: json['date'],
      );

  NewsPost toNewsPostEntity() => NewsPost(
        type: type,
        title: title,
        imageUrl: imageUrl,
        city: city,
        date: date
      );
}
