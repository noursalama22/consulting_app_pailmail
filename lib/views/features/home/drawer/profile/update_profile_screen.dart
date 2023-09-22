import 'dart:io';

import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/providers/auth_provider.dart';
import 'package:consulting_app_pailmail/repositories/auth_repository.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_auth_button_widget.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_text_forn_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/routers/router.dart';
import '../../../../../storage/shared_prefs.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_profile_image.dart';

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

  late Future<String>? newPath;
  File? pickedFile;
  String? filePath;
  String? currentImagePath;
  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return null;
    }
    File imageFile = File(pickedImage.path);
    return imageFile;
  }

  updateUser(File file) {
    print('edit 1');
    if (_updateFormKey.currentState!.validate()) {
      print('edit valid 2');
      AuthRepository().uploadImage(file, updateNameController.text).then(
        (value) async {
          await Provider.of<AuthProvider>(context, listen: false)
              .fetchCurrentUser();
          // set locally
          await SharedPrefrencesController()
              .setData(PrefKeys.name.toString(), updateNameController.text);
          print('------------------------------${file.path}');
          // await SharedPrefrencesController().setData(PrefKeys.image.toString(),
          //     AuthProvider().currentUser.data?.user.image);
          // await SharedPrefrencesController()
          //     .setData(PrefKeys.image.toString(), file.path);
          setState(() {});
          if (mounted) {
            NavigationRoutes()
                .jump(context, Routes.profile_screen, replace: true);
          }
        },
      );
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
                    alignment: Alignment.bottomRight,
                    children: [
                      // SizedBox(
                      //   height: 200.h,
                      //   width: 200.h,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(100.r),
                      //     child: pickedFile == null
                      //         ? Image.network(
                      //             '$imageUrl/${widget.image}',
                      //             fit: BoxFit.cover,
                      //           )
                      //         : Image.file(File(pickedFile!.path)),
                      //   ),
                      // ),

                      pickedFile == null
                          ? CustomProfileImage(
                              image: NetworkImage(
                                '$imageUrl/${widget.image}',
                              ),
                            )
                          : CustomProfileImage(
                              image: FileImage(File(pickedFile!.path)),
                            ),
                      InkWell(
                        onTap: () async {
                          pickedFile = await pickImage();
                          if (pickedFile != null) {
                            filePath = pickedFile!.path;
                          }
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: kYellowColor,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: kYellowColor),
                            child: Icon(
                              size: 32,
                              Icons.camera_alt,
                              color: kWhiteColor,
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
                            updateUser(pickedFile!);
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
