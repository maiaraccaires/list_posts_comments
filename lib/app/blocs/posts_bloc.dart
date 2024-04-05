import 'package:bloc/bloc.dart';

import '../services/placeholder_service.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PlaceholderService service;
  PostsBloc(this.service) : super(PostsLoaded([])) {
    on<FetchPostsEvent>(_getPosts);
  }

  void _getPosts(FetchPostsEvent event, Emitter<PostsState> emit) async {
    emit(LoadingPosts());
    try {
      final posts = await service.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError('Erro: $e'));
    }
  }
}
