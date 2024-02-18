import 'package:go_router/go_router.dart';
import 'package:make_something/bottom_nav.dart';
import 'package:make_something/pages/home.dart';
import 'package:make_something/pages/settings.dart';

// GoRouter configuration
final routes = GoRouter(
  initialLocation: '/',
  routes: [
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
);
