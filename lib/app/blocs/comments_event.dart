abstract class CommentsEvent {
  const CommentsEvent();
}

class FetchCommentsEvent extends CommentsEvent {
  final int postId;

  FetchCommentsEvent(this.postId);
}
