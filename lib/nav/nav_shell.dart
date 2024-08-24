import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:make_something/nav/admin_bottom_nav.dart';
import 'package:make_something/nav/app_bar.dart';
import 'package:make_something/nav/bottom_nav.dart';
import 'package:make_something/nav/drawer.dart';
import 'package:make_something/routes.dart';
import 'package:make_something/utils/logging.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location();

    final isCurrentRouteAdmin = location.contains("/admin");

    logger.d("CURRENT ROUTE: $location");
    logger.d("IS ADMIN ROUTE: $isCurrentRouteAdmin");
    return Scaffold(
        appBar: NavShellAppBar(key: const Key("app-bar")),
        drawer: AppDrawer(),
        body: navigationShell,
        // TODO: Use Switch case for different bottom bars.
        // IE Normal, admin, profile etc..
        bottomNavigationBar: isCurrentRouteAdmin
            ? AdminNavShellNavBar(navigationShell: navigationShell)
            : NavShellNavBar(navigationShell: navigationShell));
  }
}
