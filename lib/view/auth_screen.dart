import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_ai/services/auth_service.dart';
import 'package:shop_ai/services/storage_service.dart';
import 'package:shop_ai/view/home_screen.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.storageService});
  final StorageService storageService;
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SupaEmailAuth(
                      localization: const SupaEmailAuthLocalization(
                        enterEmail: 'Email',
                        enterPassword: 'Mot de passe',
                        signIn: 'Se connecter',
                        signUp: 'S\'inscrire',
                        forgotPassword: 'Mot de passe oublié',
                        haveAccount: 'Vous avez déjà un compte ?',
                        dontHaveAccount: 'Vous n\'avez pas de compte ?',
                      ),
                      onSignInComplete: (response) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              storageService: widget.storageService,
                            ),
                          ),
                        );
                      },
                      onSignUpComplete: (response) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              storageService: widget.storageService,
                            ),
                          ),
                        );
                      },
                      metadataFields: [
                        MetaDataField(
                          prefixIcon: const Icon(Icons.person),
                          label: 'Prénom',
                          key: 'username',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter something';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
