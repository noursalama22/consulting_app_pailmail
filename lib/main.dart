import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:consulting_app_pailmail/utils/helpers/routers/route_helper.dart';
import 'package:consulting_app_pailmail/views/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [
        Locale('en'),
        //  Locale('ar'),
      ],
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: kBackgroundColor),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      // locale: Locale('en'),
      locale: context.locale,
      home: const HomeScreen(),
      // home: SplashScreen(duration: Duration(seconds: 3)),
    );
  }
}
