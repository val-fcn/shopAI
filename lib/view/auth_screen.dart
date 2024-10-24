import 'package:flutter/material.dart';
import 'package:shop_ai/services/auth_service.dart';
import 'package:shop_ai/services/storage_service.dart';

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userEmailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          controller: userPasswordController,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            AuthService().signUp(
                              userEmailController.text,
                              userPasswordController.text,
                            );
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
