import 'dart:io';

import 'package:consulting_app_pailmail/providers/auth_provider.dart';
import 'package:consulting_app_pailmail/views/features/home/drawer/profile/update_profile_screen.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_auth_button_widget.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/api_helpers/api_response.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_profile_menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? pickedFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: kLightBlueColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: kGradient,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (_, authProvider, __) {
          if (authProvider.currentUser.status == ApiStatus.LOADING) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (authProvider.currentUser.status == ApiStatus.ERROR) {
            return Center(
              child: Text('${authProvider.currentUser.message}'),
            );
          }
          String? userName = authProvider.currentUser.data?.user.name;
          String? userImage = authProvider.currentUser.data?.user.image ?? '';
          String? userEmail = authProvider.currentUser.data?.user.email;
          String? userRole =
              authProvider.currentUser.data!.user.role!.name ?? '';

          return SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomProfileContainerImage(userImage: userImage),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileMenuWidget(
                        viewRoles: false,
                        title: "$userName",
                        icon: Icons.person,
                      ),
                      ProfileMenuWidget(
                        viewRoles: false,
                        title: "$userEmail",
                        icon: Icons.alternate_email_outlined,
                      ),
                      ProfileMenuWidget(
                        viewRoles: false,
                        title: "$userRole",
                        icon: Icons.recent_actors_outlined,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              CustomAuthButtonWidget(
                  title: 'Edit Profile',
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return UpdateProfileScreen(
                          name: userName!,
                          image: userImage,
                        );
                      },
                    ));
                    // NavigationRoutes().jump(
                    //     context, Routes.update_profile_screen,
                    //     replace: true,
                    //
                    // );
                  }),
            ]),
          );
        },
      ),
    );
  }
}

class CustomProfileContainerImage extends StatelessWidget {
  const CustomProfileContainerImage({
    super.key,
    required this.userImage,
  });

  final String? userImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 100.h),
            decoration: BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.r),
                  bottomRight: Radius.circular(50.r),
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: ImageFade(
                      // whenever the image changes, it will be loaded, and then faded in:
                      image: NetworkImage('$imageUrl/$userImage'),
                      // slow fade for newly loaded images:
                      duration: const Duration(milliseconds: 900),

                      // if the image is loaded synchronously (ex. from memory), fade in faster:
                      syncDuration: const Duration(milliseconds: 150),

                      // supports most properties of Image:
                      alignment: Alignment.center,
                      fit: BoxFit.cover,

                      // shown behind everything:
                      placeholder: Container(
                        color: kLightGreyColor,
                        alignment: Alignment.center,
                        child: const Icon(Icons.photo,
                            color: Colors.white70, size: 50.0),
                      ),

                      // shows progress while loading an image:
                      loadingBuilder: (context, progress, chunkEvent) => Center(
                          child: CircularProgressIndicator(value: progress)),

                      // displayed when an error occurs:
                      errorBuilder: (context, error) => Container(
                        color: const Color(0xFF6F6D6A),
                        alignment: Alignment.center,
                        child: const Icon(Icons.person,
                            color: Colors.black26, size: 50.0),
                      ),
                    )
                    //     Image(
                    //   image: NetworkImage('$imageUrl/$userImage'),
                    // ),
                    )),
          )
        ],
      ),
    );
  }
}
