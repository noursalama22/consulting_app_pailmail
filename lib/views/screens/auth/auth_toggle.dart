import 'package:consulting_app_pailmail/views/screens/auth/sign_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(
        toggleView: toggleView,
      );
    } else {
      return SignScreen(
        toggleView: toggleView,
      );
    }
  }
}
