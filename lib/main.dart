import 'package:flutter/material.dart';
import 'package:shop_ai/env/env.dart';
import 'package:shop_ai/services/storage_service.dart';
import 'package:shop_ai/theme.dart';
import 'package:shop_ai/view/auth_screen.dart';
import 'package:shop_ai/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseKey,
  );
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);
  runApp(MainApp(storageService: storageService));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.storageService});
  final StorageService storageService;

  final bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: AuthScreen(storageService: storageService),
        ),
      ),
    );
  }
}
