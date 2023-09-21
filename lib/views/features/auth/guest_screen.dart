import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/providers/auth_provider.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () async {
            await AuthProvider().logout();
            await SharedPrefrencesController().clear();
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   Navigator.pushRepvylacement(context,
            //       MaterialPageRoute(builder: (_) => const LoginScreen()));
            //   setState(() {});
            // });
            NavigationRoutes().pushUntil(context, Routes.login_screen);
          },
          icon: Icon(Icons.logout),
        ),
      ]),
      backgroundColor: kBackgroundColor,
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  child: Text(
                'Sorry, you don\'t have access, please check with your administrator',
              ))
            ],
          ),
        ),
      ),
    );
  }
}
