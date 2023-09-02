import 'package:consulting_app_pailmail/utils/helpers/routers/routes.dart';
import 'package:consulting_app_pailmail/views/screens/auth/login_screen.dart';
import 'package:consulting_app_pailmail/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const SplashScreen(duration: Duration(seconds: 3)),
      );
    case Routes.login_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const LoginScreen(),
      );
    // case Routes.first:
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     screen: const FirstScreen(),
    //   );
    // case Routes.second:
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     screen: const SecondScreen(),
    //   );
    // case Routes.third:
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     screen: const ThirdScreen(),
    //   );
    // case Routes.fourth:
    //   final args = settings.arguments! as String;
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     screen: FouthScreen(params: args),
    //   );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No Route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget screen,
}) {
  return PageTransition(
    child: screen,
    type: PageTransitionType.rightToLeft,
  );
}

enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
}

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  PageTransition({
    required this.child,
    this.type = PageTransitionType.rightToLeft,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return child;
          },
          transitionDuration: duration,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            switch (type) {
              case PageTransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case PageTransitionType.rightToLeft:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(-1.0, 0.0),
                    ).animate(secondaryAnimation),
                    child: child,
                  ),
                );

              case PageTransitionType.downToUp:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.0, -1.0),
                    ).animate(secondaryAnimation),
                    child: child,
                  ),
                );

              case PageTransitionType.rightToLeftWithFade:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(-1.0, 0.0),
                      ).animate(secondaryAnimation),
                      child: child,
                    ),
                  ),
                );

              default:
                return FadeTransition(opacity: animation, child: child);
            }
          },
        );
}
