import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/general_users_provider.dart';
import '../../../../../repositories/general_users_repository.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_profile_image_widget.dart';
import '../../../../widgets/custom_profile_menu_widget.dart';

class GeneralUserProfileScreen extends StatefulWidget {
  final String image;
  final String name;
  final String email;
  final String role;
  final String id;

  const GeneralUserProfileScreen(
      {Key? key,
      required this.image,
      required this.name,
      required this.email,
      required this.role,
      required this.id})
      : super(key: key);

  @override
  State<GeneralUserProfileScreen> createState() =>
      _GeneralUserProfileScreenState();
}

class _GeneralUserProfileScreenState extends State<GeneralUserProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomAppBar(widgetName: '${widget.name} profile'),
              CustomProfileWidget(image: widget.image),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileMenuWidget(
                      title: widget.name,
                      icon: Icons.person,
                      edit: () {
                        GeneralUsersRepository().changeGeneralUserName(
                            userId: widget.id, updatedName: 'annb');
                        Provider.of<GeneralUsersProvider>(context,
                                listen: false)
                            .fetchGeneralUsersList();
                      },
                    ),
                    ProfileMenuWidget(
                      title: widget.email,
                      icon: Icons.alternate_email_outlined,
                    ),
                    ProfileMenuWidget(
                      title: widget.role,
                      icon: Icons.recent_actors_outlined,
                      edit: () {
                        // GeneralUsersRepository().changeUserRole(
                        //     userId: widget.id, updatedRoleId: '4');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60.h),
            ]),
          ),
        ),
      ),
    );
  }
}
