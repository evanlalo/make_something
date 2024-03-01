import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:make_something/auth/auth_scope.dart';
import 'package:http/http.dart' as http;
import 'package:make_something/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Future<Object> getData() async {
  String? token = await StreamAuth.getToken();
  final response = await http.get(Uri.parse("$API_URL/api/games"), headers: {
    "Authorization": "Bearer $token"
  });
  return json.decode(response.body);
}

class _HomeState extends State<Home> {
  late Future<Object> data;

  @override
  void initState() {
    super.initState();
    print("HERERE WE ARE");
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
