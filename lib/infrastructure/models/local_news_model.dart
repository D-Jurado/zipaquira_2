class LocalNewsModel {
  int? id;
  Meta? meta;
  String? title;

  LocalNewsModel({this.id, this.meta, this.title});

  LocalNewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['title'] = this.title;
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