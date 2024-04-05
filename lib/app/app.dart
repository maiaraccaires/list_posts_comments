import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/comments_bloc.dart';
import 'blocs/posts_bloc.dart';
import 'services/placeholder_service.dart';
import 'pages/posts_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Co - Teste Flutter Pleno',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PostsBloc(PlaceholderService()),
          ),
          BlocProvider(
            create: (_) => CommentsBloc(PlaceholderService()),
          ),
        ],
        child: const PostsPage(title: 'Posts'),
      ),
    );
  }
}
