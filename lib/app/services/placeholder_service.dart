import 'package:dio/dio.dart';
import 'package:teste_openco_flutter_pleno/app/models/comments_model.dart';
import 'package:teste_openco_flutter_pleno/app/models/posts_model.dart';

class PlaceholderService {
  final _dio = Dio();
  final _domain = 'https://jsonplaceholder.typicode.com';

  Future<List<PostsModel>> getPosts() async {
    final response = await _dio.get('$_domain/posts');
    if (response.statusCode == 200) {
      var jsonList = response.data as List;
      return jsonList.map((posts) => PostsModel.fromMap(posts)).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<CommentsModel>> getCommentByPost({required int id}) async {
    final response = await _dio.get('$_domain/posts/$id/comments');

    if (response.statusCode == 200) {
      var jsonList = response.data as List;

      return jsonList
          .map((comments) => CommentsModel.fromMap(comments))
          .toList();
    } else {
      throw Exception();
    }
  }
}
