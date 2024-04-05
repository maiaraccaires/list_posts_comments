import 'package:dio/dio.dart';
import 'package:teste_openco_flutter_pleno/app/models/comments_model.dart';
import 'package:teste_openco_flutter_pleno/app/models/posts_model.dart';

class PlaceholderService {
  final Dio dio;

  PlaceholderService(this.dio);

  final _domain = 'https://jsonplaceholder.typicode.com';

  Future<List<PostsModel>> getPosts() async {
    final response = await dio.get('$_domain/posts');
    if (response.statusCode == 200) {
      var jsonList = response.data as List;
      return jsonList.map((posts) => PostsModel.fromMap(posts)).toList();
    } else {
      throw Exception();
    }
  }

  Future<PostsModel> getPostsById({required String id}) async {
    final response = await dio.get('$_domain/posts/$id');
    if (response.statusCode == 200) {
      var post = response.data;
      return PostsModel.fromMap(post);
    } else {
      throw Exception();
    }
  }

  Future<List<CommentsModel>> getCommentByPost({required String id}) async {
    final response = await dio.get('$_domain/posts/$id/comments');
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
