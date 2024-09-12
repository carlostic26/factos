import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/launch/presentation/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Factos',
      theme: factosThemeApp,
      home: const LoadingScreen(),
    ),
  ));
}
