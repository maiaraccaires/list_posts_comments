import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'blocs/comments_bloc.dart';
import 'blocs/posts_bloc.dart';
import 'services/placeholder_service.dart';
import 'pages/comments_page.dart';
import 'pages/posts_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<Dio>(() => Dio());
    i.addSingleton<PlaceholderService>(() => PlaceholderService(i.get<Dio>()));
    i.addLazySingleton<PostsBloc>(() => PostsBloc(i.get<PlaceholderService>()));
    i.addLazySingleton<CommentsBloc>(
        () => CommentsBloc(i.get<PlaceholderService>()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const PostsPage());
    r.child('/comments/:postId',
        child: (context) => CommentsPage(postId: r.args.params["postId"]));
  }
}
