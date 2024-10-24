import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }
}
