import 'package:flutter/material.dart';
export 'routes.dart';

class NavigationRoutes {
  void push(context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  void pushReplacement(context, String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(context, String routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  void pop(context) {
    Navigator.pop(context);
  }
}
