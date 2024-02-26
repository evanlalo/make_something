import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:make_something/nav/app_bar.dart';
import 'package:make_something/nav/bottom_nav.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavShellAppBar(key: const Key("app-bar")),
        body: navigationShell,
        bottomNavigationBar: NavShellNavBar(navigationShell: navigationShell));
  }
}
