import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:make_something/auth/page.dart';
import 'package:make_something/nav/nav_shell.dart';
import 'package:make_something/pages/admin/games/game_form.dart';
import 'package:make_something/pages/admin/home/home.dart';
import 'package:make_something/pages/admin/games/games.dart';
import 'package:make_something/pages/help/help.dart';
import 'package:make_something/pages/home/home.dart';
import 'package:make_something/pages/polls/polls.dart';
import 'package:make_something/pages/stats/stats.dart';

// GoRouter configuration
final routes = GoRouter(
  initialLocation: '/',
  observers: [NavigatorObserver()],
  refreshListenable: AuthStream(FirebaseAuth.instance.authStateChanges()),
  routes: [
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),

    // Bottom Nav Routes
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // the UI shell
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/',
              name: 'home',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Home()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/polls',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Polls()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/stats',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Stats()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/help',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Help()),
            ),
          ]),
        ]),

    // Drawer Routes
    // TODO: Add Routes for profile??

    // Admin Routes
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // the UI shell
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/admin',
              name: 'admin',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Admin()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/admin/games',
                name: 'adminGames',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: Games()),
                routes: [
                  GoRoute(
                    path: 'games/add',
                    name: 'addGame',
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: GameForm()),
                  ),
                ]),
          ]),
        ]),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    final user = FirebaseAuth.instance.currentUser;

    final loggingIn = state.matchedLocation == '/login';
    if (user == null && !loggingIn) {
      // If user is not signed in, redirect to the login page
      return '/login';
    }

    if (user != null && loggingIn) {
      return '/';
    }

    // if (state.matchedLocation.contains('admin') && !user!.isAdmin) {
    //   logger.e("Redirecting non-admin user");
    //   return '/';
    // }

    // no need to redirect at all
    return null;
  },
);

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
