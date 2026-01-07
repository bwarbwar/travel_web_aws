import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const AvantourApp());
}

class AvantourApp extends StatelessWidget {
  const AvantourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avantour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0EA5E9),
          primary: const Color(0xFF0EA5E9),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const HomePage(),
    );
  }
}
