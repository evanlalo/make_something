import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:make_something/routes.dart';
import 'package:make_something/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env", isOptional: true);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Yardsi';
    return ChangeNotifierProvider(
        create: (_) => AuthStream(FirebaseAuth.instance.authStateChanges()),
        child: MaterialApp.router(
            title: appName,
            routerConfig: routes,
            debugShowCheckedModeBanner: false,
            theme: theme));
  }
}
