import 'package:consulting_app_pailmail/repositories/roles_repository.dart';
import 'package:consulting_app_pailmail/storage/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helpers/routers/router.dart';
import '../../../core/utils/constants.dart';

import '../../widgets/custom_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  final Duration duration;

  const SplashScreen({super.key, required this.duration});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  void checkLogin() async {
    if (SharedPrefrencesController().loggedIn && mounted) {
      NavigationRoutes().jump(context, Routes.welcome_screen, replace: true);
    } else {
      NavigationRoutes().jump(context, Routes.login_screen, replace: true);
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: widget.duration, vsync: this)
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              checkLogin();
              // NavigationRoutes().jump(context, Routes.login_screen, replace: true);
            }
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlueColor,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Center(
            child: CustomLogoWidget(),
          );
        },
      ),
    );
  }
}
