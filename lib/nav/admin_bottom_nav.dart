import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminNavShellNavBar extends StatelessWidget {
  const AdminNavShellNavBar({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('AdminNavShellNavBar'));
  final StatefulNavigationShell navigationShell;
  
  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      destinations: const [
        NavigationDestination(label: "Admin", icon: Icon(Icons.home)),
        NavigationDestination(label: "Games", icon: Icon(Icons.sports_football_rounded)),
      ],
      onDestinationSelected: _goBranch,
    );
  }
}
