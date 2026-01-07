import 'package:flutter/material.dart';

import 'check_out.dart';
import 'group_calendar_page.dart';
import 'home_page.dart';
import 'private_corporate_page.dart';
import 'travel_detail.dart';

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
      routes: {
        '/checkout': (context) => const CheckoutPage(),
        '/group-calendar': (context) => const GroupCalendarPage(),
        '/private-corporate': (context) => const PrivateCorporatePage(),
        '/tour-detail': (context) => const TravelDetailPage(),
      },
    );
  }
}
