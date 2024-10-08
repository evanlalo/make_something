import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int hexToInteger(String hex) => int.parse(hex, radix: 16);

const primary = "0D3B66";

final theme = ThemeData(
  useMaterial3: true,

  // Define the default brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(hexToInteger(primary)),
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
    bodyMedium: GoogleFonts.merriweather(
      fontSize: 16
    ),
    bodySmall: GoogleFonts.merriweather(
      fontSize: 14
    ),
    displaySmall: GoogleFonts.pacifico(),
  ),
);
