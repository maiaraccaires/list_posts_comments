import 'dart:convert';

class PostsModel {
  int? id;
  String? title;
  String? body;

  PostsModel({
    this.id,
    this.title,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostsModel.fromMap(Map<String, dynamic> map) {
    return PostsModel(
      id: map['id']?.toInt(),
      title: map['title'],
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostsModel.fromJson(String source) =>
      PostsModel.fromMap(json.decode(source));

  @override
  String toString() => 'Posts(id: $id, title: $title, body: $body)';
}
