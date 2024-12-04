import 'package:flutter/material.dart';
import 'package:notification/hide_file/auth_google.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
            child: const Text("data"),
            onPressed: () async {
              await signInWithGoogle();
            }),
      ),
    );
  }
}
