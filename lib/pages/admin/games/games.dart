import 'package:flutter/material.dart';
import 'package:make_something/models/game.dart';
import 'package:make_something/pages/admin/games/game_form.dart';
import 'package:make_something/services/http/http.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

Future<List<Game>> getGames() async {
  final response = await dio.get('/games');
  List<dynamic> body = response.data;
  List<Game> games = body.map((e) => Game.fromJson(e)).toList();

  return games;
}

class _GamesState extends State<Games> with WidgetsBindingObserver {
  late Future<List<Game>> _futureGames;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _futureGames = getGames();
  }

  void removeGame(game) async {
    await dio.delete('/games/${game.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: FutureBuilder<List<Game>>(
          future: getGames(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("Add some games! Click the \"+\" to start!");
            }
            final games = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                    title: Text('Floating SliverAppBar'),
                    automaticallyImplyLeading: false,
                    floating: true,
                    expandedHeight: 100.0,
                    actions: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.add_circle),
                          tooltip: 'Add new entry',
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const GameForm()))
                              }),
                    ]),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Dismissible(
                          key: Key(games[index].name),
                          onDismissed: (direction) {
                            // Handle the dismissal action
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${games[index].name} removed!'),
                                duration: Duration(milliseconds: 500),
                              ),
                            );
                            removeGame(games[index]);
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Card(
                              child: ListTile(
                            title: Text(games[index].name),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameForm(game: games[index],)))
                              },
                            ),
                          )));
                    },
                    childCount: games.length,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
