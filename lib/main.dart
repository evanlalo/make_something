import 'package:flutter/material.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:make_something/routes.dart';
import 'package:make_something/theme.dart';

void main() {
  runApp(StreamAuthScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Yardsi';
    return MaterialApp.router(
        title: appName,
        routerConfig: routes,
        debugShowCheckedModeBanner: false,
        theme: theme
    );
  }
}