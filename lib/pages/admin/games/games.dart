import 'package:flutter/material.dart';
import 'package:make_something/models/game.dart';
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

class _GamesState extends State<Games> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: FutureBuilder<List<Game>>(
          future: futureGames,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final games = snapshot.data!;
              return gameCards(games);
            } else {
              return const Text("No data available");
            }
          },
        ));
  }

  Widget gameCards(List<Game> games) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(flex: 1, child: Text(game.name)),
              Expanded(flex: 1, child: Text(game.description)),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }
}
