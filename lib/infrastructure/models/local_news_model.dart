import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class LocalNewsModel {
  int? id;
  Meta? meta;
  String? title;
  String? type;
  String? description;
  String? body;
  String? author;
  String? imageUrl; 

  LocalNewsModel({this.id, this.meta, this.title});

  LocalNewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    title = utf8.decode(json['title'].codeUnits);
    imageUrl = json['image_url']; // Agrega la propiedad imageUrl si existe en tu JSON
  }

  set imageData(List<int> imageData) {}

  String getFormattedDate() {
    initializeDateFormatting('es');

    if (meta != null && meta!.firstPublishedAt != null) {
      DateTime firstPublishedDate = DateTime.parse(meta!.firstPublishedAt!);
      var formatter = DateFormat("MMM d, y", 'es');
      return formatter.format(firstPublishedDate);
    } else {
      return ''; // Otra cadena o valor predeterminado en caso de que firstPublishedAt sea nulo
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['title'] = this.title;
    data['image_url'] = this.imageUrl; // Agrega la propiedad imageUrl al JSON
    return data;
  }
}

class Meta {
  String? type;
  String? detailUrl;
  String? htmlUrl;
  String? slug;
  String? firstPublishedAt;

  Meta(
      {this.type,
      this.detailUrl,
      this.htmlUrl,
      this.slug,
      this.firstPublishedAt});

  Meta.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    detailUrl = json['detail_url'];
    htmlUrl = json['html_url'];
    slug = json['slug'];
    firstPublishedAt = json['first_published_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['detail_url'] = this.detailUrl;
    data['html_url'] = this.htmlUrl;
    data['slug'] = this.slug;
    data['first_published_at'] = this.firstPublishedAt;
    return data;
  }
}
