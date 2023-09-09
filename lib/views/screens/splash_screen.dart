import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/routers/router.dart';
import '../widgets/custom_logo_widget.dart';

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
              NavigationRoutes()
                  .jump(context, Routes.search_filters_screen, replace: true);
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
