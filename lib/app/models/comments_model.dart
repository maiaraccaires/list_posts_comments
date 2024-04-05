import 'dart:convert';

class CommentsModel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  CommentsModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory CommentsModel.fromMap(Map<String, dynamic> map) {
    return CommentsModel(
      postId: map['postId']?.toInt(),
      id: map['id']?.toInt(),
      name: map['name'],
      email: map['email'],
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentsModel.fromJson(String source) =>
      CommentsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comments(postId: $postId, id: $id, name: $name, email: $email, body: $body)';
  }
}
