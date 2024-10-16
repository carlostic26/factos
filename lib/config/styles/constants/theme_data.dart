import 'package:flutter/material.dart';

const Color scaffoldBackgroundColor = Color(0xFF1F1F1F);
const Color buttonLigthColor = Color.fromARGB(255, 161, 161, 161);
const Color buttonNoLigthColor = Color.fromARGB(255, 103, 103, 103);
const Color searchFieldBackgroundColor = Color(0xFF595959);
const Color titleTextColor = Color(0xFFDBDBDB);
const Color subtitleTextColor = Color(0xFFACACAC);
const Color lightBackgroundTextColor = Color(0xFF1F1F1F);

final ThemeData factosThemeApp = ThemeData(
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  primaryColor: buttonLigthColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 75, 75, 75),
    surface: scaffoldBackgroundColor,
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
