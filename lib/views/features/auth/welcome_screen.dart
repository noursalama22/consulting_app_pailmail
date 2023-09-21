import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/storage/shared_prefs.dart';
import 'package:consulting_app_pailmail/views/features/auth/guest_screen.dart';
import 'package:consulting_app_pailmail/views/features/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/routers/router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    SharedPrefrencesController prefs = SharedPrefrencesController();
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (prefs.roleName != 'guest') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return GuestScreen();
            },
          ),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: spinkit,
    );
  }
}