import 'package:flutter/material.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:make_something/models/game.dart';
import 'package:make_something/pages/admin/games/games.dart';
import 'package:make_something/services/http/http.dart';
import 'package:make_something/widgets/snackbarwidget.dart';

class GameForm extends StatefulWidget {
  /// Creates a [GameForm].
  const GameForm({super.key, this.game});

  final Game? game;

  @override
  State<GameForm> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final TextEditingController nameController;
  late final TextEditingController rulesController;

  final _formKey = GlobalKey<FormState>();
  bool active = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.game?.name ?? '');
    rulesController = TextEditingController(text: widget.game?.rules ?? '');

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    nameController.dispose();
    rulesController.dispose();
    super.dispose();
  }

  Future<bool> saveGame() async {
    final response = await dio.post('/games', data: {
      "name": nameController.text,
      "rules": rulesController.text,
      "active": active
    });

    if (response.statusCode! > 200) {
      return true;
    }

    return false;
  }

  void returnToGames() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Games()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Game Name',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: rulesController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Rules',
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: SwitchListTile(
                              title: const Text('Active'),
                              value: active,
                              onChanged: (bool value) {
                                setState(() {
                                  active = value;
                                });
                              },
                              secondary: active
                                  ? const Icon(Icons.check)
                                  : const Icon(Icons.cancel_outlined),
                            )),
                        Row(children: [
                          ElevatedButton(
                            onPressed: () {
                              returnToGames();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              saveGame()
                                  .then((value) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                SnackBarWdiget.displaySnackBar(
                                                    "Game added!", context))
                                      })
                                  .then((value) => returnToGames());
                            },
                            child: const Text('Save'),
                          ),
                        ]),
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
}
