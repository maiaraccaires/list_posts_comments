import 'package:bloc/bloc.dart';

import '../models/posts_model.dart';
import '../services/placeholder_service.dart';
import 'comments_event.dart';
import 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PlaceholderService service;
  CommentsBloc(this.service) : super(CommentsLoaded([], PostsModel())) {
    on<FetchCommentsEvent>(_getComments);
  }

  void _getComments(
      FetchCommentsEvent event, Emitter<CommentsState> emit) async {
    emit(LoadingComments());
    try {
      final post = await service.getPostsById(id: event.postId);
      final comments = await service.getCommentByPost(id: event.postId);
      emit(CommentsLoaded(comments, post));
    } catch (e) {
      emit(ErrorComments('Não há comentários'));
    }
  }
}
