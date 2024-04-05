import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../blocs/comments_event.dart';
import '../blocs/comments_state.dart';
import '../blocs/comments_bloc.dart';

class CommentsPage extends StatefulWidget {
  final String postId;

  const CommentsPage({
    super.key,
    required this.postId,
  });

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final _commentsBloc = Modular.get<CommentsBloc>();

  @override
  void initState() {
    super.initState();
    _commentsBloc.add(FetchCommentsEvent(widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: BlocBuilder<CommentsBloc, CommentsState>(
          bloc: _commentsBloc,
          builder: (context, state) {
            if (state is ErrorComments) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is CommentsLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.green.shade700),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.green,
                                    child: const Icon(
                                      Icons.comment_outlined,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: Text(
                                      'COMMENTS',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'To: ${state.data[index].email}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  state.data[index].name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(state.data[index].body!),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          }),
    );
  }
}
