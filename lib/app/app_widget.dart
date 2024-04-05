import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');
    return MaterialApp.router(
      title: 'Open Co - Teste Flutter Pleno',
      theme: ThemeData(primarySwatch: Colors.green),
      routerConfig: Modular.routerConfig,
    );
  }
}
