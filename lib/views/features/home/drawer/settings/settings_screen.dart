import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/providers/general_users_provider.dart';
import 'package:consulting_app_pailmail/repositories/general_users_repository.dart';
import 'package:consulting_app_pailmail/views/features/home/drawer/settings/general_user_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/helpers/api_helpers/api_response.dart';
import '../../../../../models/users/user.dart';
import '../../../../widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GeneralUsersProvider generalUsersProvider = GeneralUsersProvider();
  GeneralUsersRepository generalUsersRepository = GeneralUsersRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  CustomAppBar(widgetName: 'Settings'),
                  Consumer<GeneralUsersProvider>(
                    builder: (_, generalUsersProvider, __) {
                      if (generalUsersProvider.generalUsersList.status ==
                          ApiStatus.LOADING) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (generalUsersProvider.generalUsersList.status ==
                          ApiStatus.ERROR) {
                        return Center(
                          child: Text(
                              '${generalUsersProvider.generalUsersList.message}'),
                        );
                      }
                      return Center(
                          child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount:
                            generalUsersProvider.generalUsersList.data!.length,
                        itemBuilder: (context, index) {
                          User user = generalUsersProvider
                              .generalUsersList.data![index];
                          return Slidable(
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: ScrollMotion(),
                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                Spacer(),
                                SlidableAction(
                                  onPressed: (context) async {
                                    bool isDeleted =
                                        await GeneralUsersRepository()
                                            .deleteGeneralUser(
                                      userId:
                                          '${generalUsersProvider.generalUsersList.data![index].id}',
                                    );
                                    isDeleted
                                        ? Provider.of<GeneralUsersProvider>(
                                                context,
                                                listen: false)
                                            .fetchGeneralUsersList()
                                        : null;
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  backgroundColor: kRedColor.withOpacity(0.9),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                generalUsersRepository.getSingleGeneralUser(
                                    userId:
                                        '${generalUsersProvider.generalUsersList.data![index].id}');
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    String name =
                                        '${generalUsersProvider.generalUsersList.data![index].name}';
                                    String id =
                                        '${generalUsersProvider.generalUsersList.data![index].id}';
                                    String image =
                                        '${generalUsersProvider.generalUsersList.data![index].image}';
                                    String email =
                                        '${generalUsersProvider.generalUsersList.data![index].email}';
                                    String role =
                                        '${generalUsersProvider.generalUsersList.data![index].role!.name}';
                                    return GeneralUserProfileScreen(
                                      image: image,
                                      name: name,
                                      email: email,
                                      role: role,
                                      id: id,
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? kLightBlueColor
                                        : kLightGreyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${user.name}',
                                      style: TextStyle(
                                        color: index % 2 == 1
                                            ? kPrimaryBlueColor
                                            : kMediumGreyColor,
                                      ),
                                    ),
                                    Text(
                                      '${user.email}',
                                      style: TextStyle(
                                        color: index % 2 == 1
                                            ? kLightBlueColor
                                            : kLightGreyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                          //   Row(
                          //   children: [
                          //     IconButton(
                          //         onPressed: () {
                          //           GeneralUsersRepository().changeUserRole(
                          //               userId:
                          //                   '${generalUsersProvider.generalUsersList.data![index].id}',
                          //               updatedRoleId: '4');
                          //         },
                          //         icon: Icon(Icons.edit)),
                          //     IconButton(
                          //         onPressed: () async {
                          //           bool isDleted =
                          //               await GeneralUsersRepository()
                          //                   .deleteGeneralUser(
                          //             userId:
                          //                 '${generalUsersProvider.generalUsersList.data![index].id}',
                          //           );
                          //           isDleted
                          //               ? Provider.of<GeneralUsersProvider>(
                          //                       context,
                          //                       listen: false)
                          //                   .fetchGeneralUsersList()
                          //               : null;
                          //           //  setState(() {});
                          //         },
                          //         icon: Icon(Icons.delete)),
                          //     IconButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             GeneralUsersRepository()
                          //                 .changeUserPassword(
                          //               updatedPass: '1234567',
                          //               userId:
                          //                   '${generalUsersProvider.generalUsersList.data![index].id}',
                          //             );
                          //           });
                          //           generalUsersProvider
                          //               .fetchGeneralUsersList();
                          //           setState(() {});
                          //         },
                          //         icon: Icon(Icons.lock)),
                          //     Text('${user.name}'),
                          //   ],
                          // );
                        },
                      ));
                    },
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
