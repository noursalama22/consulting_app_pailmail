import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/routers/router.dart';

class SplashScreen extends StatefulWidget {
  final Duration duration;

  const SplashScreen({super.key, required this.duration});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: widget.duration, vsync: this)
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              NavigationRoutes().pushNamedAndRemoveUntil(
                context,
                Routes.login_screen,
              );
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                  height: 100,
                  width: 100,
                ),
                Text('ديوان الموظفين',
                    style:
                        GoogleFonts.sansita(fontSize: 31, color: Colors.white)),
              ],
            ),
          );
        },
      ),
    );
  }
}
