import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:consulting_app_pailmail/utils/helpers/routers/route_helper.dart';
import 'package:consulting_app_pailmail/views/screens/home_screen.dart';
import 'package:consulting_app_pailmail/views/screens/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  // This widget is the root of your application.  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 812),
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(scaffoldBackgroundColor: kBackgroundColor),
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: generateRoute,
            // home: const HomeScreen(),
            home: SplashScreen(duration: Duration(seconds: 3)),
          );
        });
  }
}
