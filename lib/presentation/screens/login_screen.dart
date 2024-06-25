// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/presentation/widgets/my_button.dart';
import 'package:message_app/presentation/widgets/my_textfield.dart';
import 'package:message_app/services/auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void _auth() {
    showLoginPage ? signin() : signUp();
  }

  Future<void> signin() async {
    final _auth = Provider.of<AuthService>(context, listen: false);
    try {
      await _auth.signin(_emailController.text, _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.code,
            ),
          ),
        );
      }
    }
  }

  Future<void> signUp() async {
    final _auth = Provider.of<AuthService>(context, listen: false);
    try {
      _auth.signUp(_emailController.text, _passwordController.text);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 96,
                color: theme.primary,
              ),
              const SizedBox(height: 45),
              Text(
                showLoginPage
                    ? "Welcome back, we missed you"
                    : "Lets create an account!",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: _emailController,
                hintText: "Email",
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                controller: _passwordController,
                hintText: "Password",
              ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                text: showLoginPage ? "Sign In" : "Sign Up",
                onTap: () => _auth(),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    showLoginPage
                        ? "Not a member?, "
                        : "Already have an account? ",
                    style: const TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      togglePages();
                    },
                    child: Text(
                      showLoginPage ? "Register now" : "Log in",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
