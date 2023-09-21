
import 'package:consulting_app_pailmail/providers/categories_provider.dart';

import 'package:consulting_app_pailmail/providers/sender_provider.dart';
import 'package:consulting_app_pailmail/providers/status_provider.dart';
import 'package:consulting_app_pailmail/providers/tag_provider.dart';

import 'package:consulting_app_pailmail/providers/auth_provider.dart';

import 'package:consulting_app_pailmail/providers/mails_provider.dart';


import 'package:consulting_app_pailmail/providers/auth_provider.dart';

import 'package:consulting_app_pailmail/providers/mails_provider.dart';

import 'package:consulting_app_pailmail/providers/categories_provider.dart';

import 'package:consulting_app_pailmail/providers/general_users_provider.dart';
import 'package:consulting_app_pailmail/providers/roles_provider.dart';
import 'package:consulting_app_pailmail/providers/sender_provider.dart';
import 'package:consulting_app_pailmail/providers/status_provider.dart';
import 'package:consulting_app_pailmail/providers/tag_provider.dart';
import 'package:consulting_app_pailmail/storage/shared_prefs.dart';
import 'package:consulting_app_pailmail/views/features/auth/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/helpers/routers/route_helper.dart';
import 'core/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPrefrencesController().initPref();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('ar'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.  @override
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SenderProvider>(
          create: (_) => SenderProvider(),
        ),
        ChangeNotifierProvider<TagProvider>(
          create: (_) => TagProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<RoleProvider>(create: (_) => RoleProvider()),
        ChangeNotifierProvider<MailProvider>(create: (_) => MailProvider()),
        ChangeNotifierProvider<StatusProvider>(create: (_) => StatusProvider()),

        ChangeNotifierProvider<GeneralUsersProvider>(
            create: (_) => GeneralUsersProvider()),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (context) => CategoriesProvider(),
        )
      ],
      child: ScreenUtilInit(
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
              //      home: const SearchScreen(),

              home: const SplashScreen(duration: Duration(seconds: 3)),
            );
          }),
    );
  }
}
