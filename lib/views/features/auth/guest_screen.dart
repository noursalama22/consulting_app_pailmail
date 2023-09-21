import 'package:consulting_app_pailmail/providers/auth_provider.dart';
import 'package:consulting_app_pailmail/views/features/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/helpers/routers/router.dart';
import '../../../core/helpers/routers/routes.dart';
import '../../../storage/shared_prefs.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({Key? key}) : super(key: key);

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () async {
            await AuthProvider().logout();
            await SharedPrefrencesController().clear();
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (_) => const LoginScreen()));
            //   setState(() {});
            // });
            NavigationRoutes().pushUntil(context, Routes.login_screen);
          },
          icon: Icon(Icons.logout),
        ),
      ),
    );
  }
}
