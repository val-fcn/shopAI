import 'package:flutter/material.dart';
import 'package:shop_ai/services/storage_service.dart';
import 'package:shop_ai/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);
  runApp(MainApp(storageService: storageService));
}

class MainApp extends StatelessWidget {
  final StorageService storageService;
  const MainApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(child: HomeScreen(storageService: storageService)),
      ),
    );
  }
}
