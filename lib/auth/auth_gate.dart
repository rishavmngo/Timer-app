import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timer_app/pages/home_page.dart';
import 'package:timer_app/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FirebaseAuth.instance.currentUser != null
            ? const HomePage()
            : const LoginPage());
  }
}
