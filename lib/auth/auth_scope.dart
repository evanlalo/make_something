import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:make_something/utils/logging.dart';

/// A scope that provides [StreamAuth] for the subtree.

class AuthStream extends ChangeNotifier {
  AuthStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((event) {
      notifyListeners(); // Notify router when the auth state changes
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  static Future<void> emailSignIn(String username, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
    } catch (e) {
      logger.e("Whoops $e");
    }
  }

  static Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return; // Sign-in aborted by user

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Signs out the current user.
  static Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }  
}
