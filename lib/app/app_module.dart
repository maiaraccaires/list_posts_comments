import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_openco_flutter_pleno/app/blocs/comments_bloc.dart';
import 'package:teste_openco_flutter_pleno/app/services/placeholder_service.dart';
import 'pages/comments_page.dart';
import 'pages/posts_page.dart';

import 'blocs/posts_bloc.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<PlaceholderService>(() => PlaceholderService());
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
