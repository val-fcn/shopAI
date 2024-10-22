import 'package:flutter/material.dart';
import 'package:shop_ai/view/home.dart';
import 'theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(child: HomeView()),
      ),
      theme: AppTheme.lightTheme,
    );
  }
}
