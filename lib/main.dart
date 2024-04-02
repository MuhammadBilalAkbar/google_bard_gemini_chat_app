import 'package:flutter/material.dart';
import '../chat_bot_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart OpenAI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          titleTextStyle:
              TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          color: Colors.blue,
        ),
      ),
      home: const ChatBotPage(),
    );
  }
}
