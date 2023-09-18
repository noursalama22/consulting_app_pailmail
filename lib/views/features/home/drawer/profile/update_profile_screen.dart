import 'dart:io';

import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/providers/auth_provider.dart';
import 'package:consulting_app_pailmail/repositories/auth_repository.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_auth_button_widget.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_profile_image_widget.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_text_forn_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/routers/router.dart';
import '../../../../widgets/custom_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String name;
  final String image;
  UpdateProfileScreen({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _updateFormKey = GlobalKey<FormState>();
  TextEditingController updateNameController = TextEditingController();

  late Future<String>? newImagePath;
  File? pickedFile;
  String? filePath;
  String? currentImagePath;

  updateUser() {
    print('edit 1');
    if (_updateFormKey.currentState!.validate()) {
      print('edit valid 2');

      AuthProvider()
          .updateCurrentUser(name: updateNameController.text, image: 'image')
          .then((user) async {
        if (mounted) {
          NavigationRoutes()
              .jump(context, Routes.profile_screen, replace: true);
        }
      });
    }
  }

  @override
  void initState() {
    updateNameController.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(widgetName: 'Edit Profile'),

                  Stack(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: pickedFile == null
                              ? CustomProfileWidget(
                                  image: '$imageUrl/${widget.image}')
                              // Image.network(
                              //         '$imageUrl/${widget.image}',
                              //         fit: BoxFit.cover,
                              //       )
                              //
                              : Image.file(File(pickedFile!.path)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            pickedFile = await AuthRepository().pickImage();

                            if (pickedFile != null) {
                              filePath = pickedFile!.path;
                            }
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: Container(
                              margin: const EdgeInsets.all(4.0),
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Icon(
                                Icons.image,
                                size: 24,
                                color: kYellowColor,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: InkWell(
                      //     onTap: () async {
                      //       pickedFile = await AuthRepository().pickImage();
                      //
                      //       if (pickedFile != null) {
                      //         filePath = pickedFile!.path;
                      //       }
                      //       setState(() {});
                      //     },
                      //     child: Container(
                      //       width: 40,
                      //       height: 40,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(100),
                      //           color: kPrimaryBlueColor),
                      //       child: Icon(
                      //         Icons.image,
                      //         color: kWhiteColor,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 60),

                  // -- Form Fields
                  Form(
                    key: _updateFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: CustomTextFormFieldWidget(
                            hint: 'New Username',
                            controller: updateNameController,
                          ),
                        ),
                        const SizedBox(height: 60),
                        CustomAuthButtonWidget(
                          title: 'update',
                          onTap: () {
                            updateUser();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
