import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:make_something/auth/page.dart';
import 'package:make_something/nav_shell.dart';
import 'package:make_something/pages/home.dart';
import 'package:make_something/pages/settings.dart';

// GoRouter configuration
final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // the UI shell
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Home()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              name:
                  'settings', // Optional, add name to your routes. Allows you navigate by name instead of path
              path: '/settings',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Settings()),
            ),
          ])
        ]),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    // Using `of` method creates a dependency of StreamAuthScope. It will
    // cause go_router to reparse current route if StreamAuth has new sign-in
    // information.
    final bool loggedIn = await StreamAuthScope.of(context).isSignedIn();
    final bool loggingIn = state.matchedLocation == '/login';
    if (!loggedIn) {
      return '/login';
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) {
      return '/';
    }

    // no need to redirect at all
    return null;
  },
);
