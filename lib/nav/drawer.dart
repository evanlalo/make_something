import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:make_something/models/user.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = StreamAuthScope.of(context).currentUser;
    return Drawer(
        child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.brown,
                        maxRadius: 50,
                        child: Text(user != null? user.initials : ''),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                  title: const Text('Home'),
                  trailing: const Icon(
                    Icons.home,
                  ),
                  onTap: () =>
                      {GoRouter.of(context).go('/'), Navigator.pop(context)}),
              ListTile(
                  title: const Text('Profile'),
                  trailing: const Icon(Icons.person),
                  onTap: () => {
                        GoRouter.of(context).go('/profile'),
                        Navigator.pop(context)
                      }),
            ],
          ),
        ),
        if (user != null && user.isAdmin)
          ListTile(
              title: const Text('Administration'),
              trailing: const Icon(
                Icons.admin_panel_settings,
              ),
              onTap: () =>
                  {GoRouter.of(context).go('/admin'), Navigator.pop(context)}),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ListTile(
              title: const Text('Sign Out'),
              trailing: const Icon(Icons.logout),
              onTap: () => StreamAuthScope.of(context).signOut()),
        )
      ],
    ));
  }
}
