import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:make_something/services/http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Future<Object> getData() async {
  final response = await dio.get('/games');

  return json.decode(response.toString());
}

class _HomeState extends State<Home> {
  late Future<Object> data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: FutureBuilder<dynamic>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container(
              color: Theme.of(context).colorScheme.background,
            );
          },
        ));
  }
}
