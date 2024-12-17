import 'package:band_names/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Band Names App',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => const HomeScreen()
      },
    );
  }
}
