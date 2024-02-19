import 'package:flutter/material.dart';
import 'package:make_something/auth/auth_scope.dart';

class NavShellAppBar extends StatefulWidget implements PreferredSizeWidget {
  NavShellAppBar({required Key key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  // ignore: library_private_types_in_public_api
  _NavShellAppBarState createState() => _NavShellAppBarState();
}

class _NavShellAppBarState extends State<NavShellAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Yardsi",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      actions: [
        IconButton(
            onPressed: () => StreamAuthScope.of(context).signOut(),
            icon: Icon(Icons.logout))
      ],
    );
  }
}
