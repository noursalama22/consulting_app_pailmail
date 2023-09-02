import 'package:consulting_app_pailmail/utils/helpers/routers/route_helper.dart';
import 'package:consulting_app_pailmail/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      home: SplashScreen(duration: Duration(seconds: 3)),
    );
  }
}
