import 'package:bloc/bloc.dart';

import '../services/placeholder_service.dart';
import 'comments_event.dart';
import 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PlaceholderService service;
  CommentsBloc(this.service) : super(CommentsLoaded([])) {
    on<FetchCommentsEvent>(_getComments);
  }

  void _getComments(
      FetchCommentsEvent event, Emitter<CommentsState> emit) async {
    emit(LoadingComments());
    try {
      final comments = await service.getCommentByPost(id: event.postId);
      emit(CommentsLoaded(comments));
    } catch (e) {
      emit(ErrorComments('Erro: $e'));
    }
  }
}
