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

  // void _goBranch(int index) {
  //   navigationShell.goBranch(
  //     index,
  //     // A common pattern when using bottom navigation bars is to support
  //     // navigating to the initial location when tapping the item that is
  //     // already active. This example demonstrates how to support this behavior,
  //     // using the initialLocation parameter of goBranch.
  //     initialLocation: index == navigationShell.currentIndex,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavShellAppBar(key: const Key("app-bar"),),
      body: navigationShell,
      bottomNavigationBar: NavShellNavBar(navigationShell: navigationShell)
    //   bottomNavigationBar: NavigationBar(
    //     selectedIndex: navigationShell.currentIndex,
    //     destinations: const [
    //       NavigationDestination(label: 'Section A', icon: Icon(Icons.home)),
    //       NavigationDestination(label: 'Section B', icon: Icon(Icons.settings)),
    //     ],
    //     onDestinationSelected: _goBranch,
    //   ),
    );
  }
}
