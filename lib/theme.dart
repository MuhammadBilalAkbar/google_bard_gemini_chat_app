import 'package:flutter/material.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
  primaryColor: Colors.blue,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    color: Colors.blue,
  ),
);
