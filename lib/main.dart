import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Yardsi';
    return MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,

          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            // ···
            brightness: Brightness.dark,
          ),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            displayLarge: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
            // ···
            titleLarge: GoogleFonts.oswald(
              fontSize: 30,
              fontStyle: FontStyle.italic,
            ),
            bodyMedium: GoogleFonts.merriweather(),
            displaySmall: GoogleFonts.pacifico(),
          ),
        ),
        home: const Body(title: appName));
  }
}

class Body extends StatelessWidget {
  final String title;

  const Body({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: 
        // routes go here
        Placeholder()
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Container(
        //       height: 200,
        //       decoration: BoxDecoration(
        //           color: Theme.of(context).colorScheme.onPrimary,
        //           borderRadius: BorderRadius.circular(20)),
        //     ),
        //     Container(
        //       height: 200,
        //       decoration: BoxDecoration(
        //           color: Theme.of(context).colorScheme.onPrimary,
        //           borderRadius: BorderRadius.circular(20)),
        //     ),
        //   ],
        // ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        items: [ 
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Theme.of(context).colorScheme.onSecondary), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.poll, color: Theme.of(context).colorScheme.onSecondary), label: "Polls"),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart, color: Theme.of(context).colorScheme.onSecondary), label: "Stats"),
          BottomNavigationBarItem(icon: Icon(Icons.help, color: Theme.of(context).colorScheme.onSecondary), label: "Help"),
          // BottomNavigationBarItem(icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onSecondary), label: "Settings"),
          ],
      ),
    );
  }
}
