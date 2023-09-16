import 'package:ChatPaLM/screens/LoginOrRegister.dart';
import 'package:ChatPaLM/screens/home_page.dart';
import 'package:ChatPaLM/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return const LoginOrRegisterPage();
              }
            }));
  }
}
