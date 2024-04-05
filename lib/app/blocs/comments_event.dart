abstract class CommentsEvent {
  const CommentsEvent();
}

class FetchCommentsEvent extends CommentsEvent {
  final String postId;

  FetchCommentsEvent(this.postId);
}
