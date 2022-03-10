import 'package:flutter/material.dart';
import 'package:office_quote_game/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office Quote Game',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(),
    );
  }
}
