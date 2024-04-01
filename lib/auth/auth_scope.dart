import 'dart:async';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:make_something/models/user.dart';
import 'package:make_something/services/http/http.dart';
import 'package:make_something/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A scope that provides [StreamAuth] for the subtree.
class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  /// Creates a [StreamAuthScope] sign in scope.
  StreamAuthScope({
    super.key,
    required super.child,
  }) : super(
          notifier: StreamAuthNotifier(),
        );

  /// Gets the [StreamAuth].
  static StreamAuth of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .notifier!
        .streamAuth;
  }
}

/// A class that converts [StreamAuth] into a [ChangeNotifier].
class StreamAuthNotifier extends ChangeNotifier {
  /// Creates a [StreamAuthNotifier].
  StreamAuthNotifier() : streamAuth = StreamAuth() {
    streamAuth.onCurrentUserChanged.listen((User? user) {
      notifyListeners();
    });
  }

  /// The stream auth client.
  final StreamAuth streamAuth;
}

/// An asynchronous log in services mock with stream similar to google_sign_in.
///
/// This class adds an artificial delay of 3 second when logging in an user, and
/// will automatically clear the login session after [refreshInterval].
class StreamAuth {
  /// Creates an [StreamAuth] that clear the current user session in
  /// [refeshInterval] second.
  StreamAuth({this.refreshInterval = 20})
      : _userStreamController = StreamController<User?>.broadcast() {
    _userStreamController.stream.listen((User? currentUser) {
      _currentUser = currentUser;
    });
  }

  /// The current user.
  User? get currentUser => _currentUser;
  User? _currentUser;

  /// Checks whether current user is signed in with an artificial delay to mimic
  /// async operation.
  Future<bool> isSignedIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return _currentUser != null;
  }

  /// A stream that notifies when current user has changed.
  Stream<User?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<User?> _userStreamController;

  /// The interval that automatically signs out the user.
  final int refreshInterval;

  /// Signs in a user with an artificial delay to mimic async operation.
  Future<bool> signIn(String username, String password) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    final response = await dio.post('/token', data: {
      "email": username,
      "password": password,
      "device_name": iosInfo.identifierForVendor
    });


    if (response.statusCode == 200) {
      String token = response.data;
      saveToken(token);
      final userRequest = await dio.get('/user');
      logger.d(userRequest.data);
      User user = User.fromJson(userRequest.data);
      _userStreamController.add(user);

      return true;
    } else {
      // Request failed
      logger.e('Request failed with status: ${response.statusCode}');
      return false;
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    _userStreamController.add(null);
  }

  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') as String;
  }
}
