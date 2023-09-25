class LocalNewsModel {
  String? type;
  String? title;
  String? imageUrl;
  String? city;
  String? date;

  LocalNewsModel({this.type, this.title, this.imageUrl, this.city, this.date});
  LocalNewsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    city = json['city'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;
    data['city'] = this.city;
    data['date'] = this.date;
    return data;
  }
}
