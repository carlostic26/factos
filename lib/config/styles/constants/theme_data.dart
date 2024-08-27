import 'package:flutter/material.dart';

const Color buttonLigthColor = Color.fromARGB(255, 179, 179, 179);
const Color factoBackgroundColor = Color.fromARGB(255, 192, 192, 192);
const Color buttonNoLigthColor = Color.fromARGB(255, 103, 103, 103);
const Color tagBackgroundColor = Color.fromARGB(255, 139, 139, 139);
const Color searchFieldBackgroundColor = Color(0xFF595959);
const Color titleTextColor = Color.fromARGB(255, 233, 233, 233);
const Color subtitleTextColor = Color(0xFFACACAC);
const Color darkBackgroundTextColor = Color.fromARGB(255, 240, 240, 240);
const Color lightBackgroundTextColor = Color.fromARGB(255, 10, 10, 10);
const Color scaffoldBackgroundGlobalColor = Color.fromARGB(255, 36, 36, 36);

final ThemeData factosThemeApp = ThemeData(
  scaffoldBackgroundColor: scaffoldBackgroundGlobalColor,
  primaryColor: buttonLigthColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 75, 75, 75),
    surface: scaffoldBackgroundGlobalColor,
    primary: buttonLigthColor,
    secondary: searchFieldBackgroundColor,
    onPrimary: lightBackgroundTextColor,
    onSecondary: lightBackgroundTextColor,
    onSurface: titleTextColor,
    onSurfaceVariant: subtitleTextColor,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: titleTextColor),
    titleMedium: TextStyle(color: subtitleTextColor),
    bodyLarge: TextStyle(color: lightBackgroundTextColor),
  ),
  iconTheme: const IconThemeData(color: lightBackgroundTextColor),
  buttonTheme: const ButtonThemeData(
    buttonColor: buttonLigthColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: searchFieldBackgroundColor,
  ),
);
