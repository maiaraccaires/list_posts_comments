import '../models/comments_model.dart';

abstract class CommentsState {}

class LoadingComments implements CommentsState {}

class CommentsLoaded implements CommentsState {
  final List<CommentsModel> data;
  CommentsLoaded(this.data);
}

class ErrorComments implements CommentsState {
  final String message;
  ErrorComments(this.message);
}
