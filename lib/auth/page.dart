import 'package:flutter/material.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool loggingIn = false;
  late final AnimationController controller;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Yardsi")),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (loggingIn)
                  CircularProgressIndicator(value: controller.value),
                if (!loggingIn)
                  Form(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await AuthStream.emailSignIn(
                              emailController.text, passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Login'),
                      ),
                      const Divider(),
                      SignInButton(
                        Buttons.GoogleDark,
                        onPressed: () async {
                          await AuthStream.signInWithGoogle();
                        },
                      ),
                      SignInButton(
                        Buttons.AppleDark,
                        onPressed: () {},
                      )
                    ],
                  ))
              ],
            ),
          ),
        ),
      );
}
