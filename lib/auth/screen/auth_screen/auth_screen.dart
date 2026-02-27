import 'package:flutter/material.dart';
import 'package:spend_note/auth/screen/auth_screen/login_screen.dart';
import 'package:spend_note/auth/screen/auth_screen/signin_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool show = true;
  void go() {
    setState(() {
      show != show;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (show) {
      return LoginScreen(go);
    } else {
      return SigninScreen(go);
    }
  }
}
