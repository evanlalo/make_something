import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:make_something/auth/page.dart';
import 'package:make_something/models/user.dart';
import 'package:make_something/nav/nav_shell.dart';
import 'package:make_something/pages/admin/admin.dart';
import 'package:make_something/pages/help/help.dart';
import 'package:make_something/pages/home/home.dart';
import 'package:make_something/pages/polls/polls.dart';
import 'package:make_something/pages/stats/stats.dart';
import 'package:make_something/utils/logging.dart';

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
              path: '/admin/polls',
              name: 'adminPolls',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Admin()),
            ),
          ]),
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

    final user = StreamAuthScope.of(context).currentUser;

    if (state.matchedLocation.contains('admin') && !user!.isAdmin) {
      logger.e("Redirecting non-admin user");
      return '/';
    }

    // no need to redirect at all
    return null;
  },
);


extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}