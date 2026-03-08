import 'package:flutter/material.dart';
import 'package:spend_note/screen/auth_page/auth_screen.dart';
import 'package:spend_note/service/auth.dart';
class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AuthPage()),
              );
              await Authentication().signOut();
            },
            child: const Text("Logout")
        ),
      ),
    );
  }
}
