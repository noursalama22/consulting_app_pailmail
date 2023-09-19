import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/api_helpers/api_response.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../models/roles/role.dart';
import '../../../../../providers/general_users_provider.dart';
import '../../../../../providers/roles_provider.dart';
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
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updatePassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  late String names;
  bool viewRoles = false;
  String _selectedRoleId = '';
  late String role;
  toggleRoles() {
    setState(() {
      viewRoles = !viewRoles;
    });
  }

  @override
  void initState() {
    names = widget.name;
    role = widget.role;
    super.initState();
  }

  @override
  void dispose() {
    updateNameController.dispose();
    updatePassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: viewRoles
          ? FloatingActionButton.extended(
              label: Text('Change Role'),
              backgroundColor: kPrimaryBlueColor,
              icon: Icon(Icons.recent_actors_outlined),
              onPressed: () async {
                await GeneralUsersRepository().changeUserRole(
                    userId: widget.id, updatedRoleId: _selectedRoleId);
                Provider.of<GeneralUsersProvider>(context, listen: false)
                    .fetchGeneralUsersList();
                toggleRoles();
              },
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              CustomAppBar(widgetName: '$names profile', bottomPadding: 4.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomProfileWidget(image: widget.image),
                        SizedBox(
                          height: 4.h,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ProfileMenuWidget(
                                viewRoles: false,
                                title: names,
                                icon: Icons.person,
                                edit: () async {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.noHeader,
                                    borderSide: BorderSide(
                                        color: kLightBlueColor, width: 1),
                                    buttonsBorderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    headerAnimationLoop: true,
                                    animType: AnimType.topSlide,
                                    title: 'Update username',
                                    desc: 'Change Username...',
                                    body: TextFormField(
                                      controller: updateNameController,
                                      autofocus: true,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Update username',
                                        hintText: widget.name,
                                        prefixIcon: Icon(Icons.text_fields),
                                      ),
                                    ),
                                    showCloseIcon: true,
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () async {
                                      print(updateNameController.text);
                                      await GeneralUsersRepository()
                                          .changeGeneralUserName(
                                              userId: widget.id,
                                              updatedName:
                                                  updateNameController.text);
                                      Provider.of<GeneralUsersProvider>(context,
                                              listen: false)
                                          .fetchGeneralUsersList();

                                      setState(() {
                                        names = updateNameController.text;
                                      });

                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        Navigator.pop(
                                          context,
                                        );
                                      });
                                    },
                                  ).show();
                                },
                              ),
                              ProfileMenuWidget(
                                viewRoles: false,
                                title: widget.email,
                                icon: Icons.alternate_email_outlined,
                              ),
                              ProfileMenuWidget(
                                viewRoles: false,
                                title: 'Change Password',
                                icon: Icons.lock,
                                edit: () async {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.noHeader,
                                    borderSide: BorderSide(
                                        color: kLightBlueColor, width: 2),
                                    buttonsBorderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    headerAnimationLoop: true,
                                    animType: AnimType.topSlide,
                                    title: 'Update Password',
                                    desc: 'Change Password...',
                                    body: Column(
                                      children: [
                                        TextFormField(
                                          controller: updatePassController,
                                          autofocus: true,
                                          minLines: 1,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'New Password',
                                            prefixIcon: Icon(Icons.password),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: confirmPassController,
                                          autofocus: true,
                                          minLines: 1,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Confirm Password',
                                            prefixIcon: Icon(Icons.password),
                                          ),
                                        ),
                                      ],
                                    ),
                                    showCloseIcon: true,
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () async {
                                      await GeneralUsersRepository()
                                          .changeUserPassword(
                                              updatedPass:
                                                  updatePassController.text,
                                              updatedConfoirmPass:
                                                  confirmPassController.text,
                                              userId: widget.id);
                                      //todo:use snackbar
                                    },
                                  ).show();
                                },
                              ),
                              ProfileMenuWidget(
                                viewRoles: viewRoles,
                                title: role,
                                icon: Icons.recent_actors_outlined,
                                edit: () {
                                  toggleRoles();
                                },
                              ),
                              viewRoles
                                  ? Consumer<RoleProvider>(
                                      builder: (_, roleProvider, __) {
                                        if (roleProvider.roleList.status ==
                                            ApiStatus.LOADING) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (roleProvider.roleList.status ==
                                            ApiStatus.ERROR) {
                                          return Center(
                                            child: Text(
                                                '${roleProvider.roleList.message}'),
                                          );
                                        }
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: roleProvider
                                              .roleList.data?.length,
                                          itemBuilder: (context, index) {
                                            Role roles = roleProvider
                                                .roleList.data![index];
                                            return RadioListTile<String>(
                                              title: Text('${roles.name}'),
                                              value: '${roles.id}',
                                              groupValue: _selectedRoleId,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _selectedRoleId = value!;
                                                  role = '${roles.name}';
                                                  setState(() {});
                                                });
                                              },
                                            );
                                          },
                                        );
                                      },
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/***/
// AwesomeDialog(
//   context: context,
//   dialogType: DialogType.warning,
//   borderSide:
//       BorderSide(color: kLightBlueColor, width: 2),
//   buttonsBorderRadius:
//       BorderRadius.all(Radius.circular(5)),
//   headerAnimationLoop: true,
//   animType: AnimType.topSlide,
//   title: 'Update role',
//   desc: 'Change Role...',
//   body: SizedBox(
//     height: 250.h,
//     child: Consumer<RoleProvider>(
//       builder: (_, roleProvider, __) {
//         if (roleProvider.roleList.status ==
//             ApiStatus.LOADING) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (roleProvider.roleList.status ==
//             ApiStatus.ERROR) {
//           return Center(
//             child: Text(
//                 '${roleProvider.roleList.message}'),
//           );
//         }
//         return ListView.builder(
//           itemCount: roleProvider.roleList.data?.length,
//           itemBuilder: (context, index) {
//             Role roles =
//                 roleProvider.roleList.data![index];
//             return RadioListTile<String>(
//               title: Text('${roles.name}'),
//               value: '${roles.id}',
//               groupValue: _selectedRoleId,
//               onChanged: (String? value) {
//                 setState(() {
//                   _selectedRoleId = value!;
//                   role = '${roles.name}';
//                   setState(() {});
//                 });
//               },
//             );
//           },
//           //     ListTile(
//           //   title: Text('${roles.name}'),
//           //   leading: Radio<String>(
//           //     value: '${roles.id}',
//           //     groupValue: _selectedRoleId,
//           //     onChanged: (String? value) {
//           //       setState(() {
//           //         _selectedRoleId = value!;
//           //         role = '${roles.name}';
//           //       });
//           //     },
//           //   ),
//           // );d
//         );
//         //   Center(
//         //   child: ListView.builder(
//         //     itemCount:
//         //         roleProvider.roleList.data?.length,
//         //     itemBuilder: (context, index) {
//         //       Role roles =
//         //           roleProvider.roleList.data![index];
//         //       return Text('${roles.name}');
//         //     },
//         //   ),
//         // );
//       },
//     ),
//   ),
//   showCloseIcon: true,
//   btnCancelOnPress: () {},
//   btnOkOnPress: () async {
//     await GeneralUsersRepository().changeUserRole(
//         userId: widget.id,
//         updatedRoleId: _selectedRoleId);
//     Provider.of<GeneralUsersProvider>(context,
//             listen: false)
//         .fetchGeneralUsersList();
//   },
// ).show();
// GeneralUsersRepository().changeUserRole(
//     userId: widget.id, updatedRoleId: '4');
