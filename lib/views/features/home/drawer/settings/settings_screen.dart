import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/providers/general_users_provider.dart';
import 'package:consulting_app_pailmail/repositories/general_users_repository.dart';
import 'package:consulting_app_pailmail/views/features/home/drawer/settings/general_user_profile.dart';
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                CustomAppBar(widgetName: 'Settings'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Consumer<GeneralUsersProvider>(
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
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: generalUsersProvider
                              .generalUsersList.data!.length,
                          itemBuilder: (context, index) {
                            User user = generalUsersProvider
                                .generalUsersList.data![index];
                            return GestureDetector(
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
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 24, vertical: 16),
                                decoration: BoxDecoration(
                                    color: kLightGreyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.person),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${user.name}',
                                          style: TextStyle(
                                            color: index % 2 == 1
                                                ? kBlackColor
                                                : kBlackColor,
                                          ),
                                        ),
                                        Text(
                                          '${user.email}',
                                          style: TextStyle(
                                            color: index % 2 == 1
                                                ? kDarkGreyColor
                                                : kDarkGreyColor,
                                          ),
                                        )
                                      ],
                                    ),

                                    IconButton(
                                      onPressed: () async {
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
                                        //  setState(() {});
                                      },
                                      icon: Icon(Icons.delete),
                                      color: kRedColor,
                                    ),

                                    // IconButton(
                                    //     onPressed: () {
                                    //       setState(() {
                                    //         GeneralUsersRepository()
                                    //             .changeUserPassword(
                                    //           updatedPass: '1234567',
                                    //           userId:
                                    //               '${generalUsersProvider.generalUsersList.data![index].id}',
                                    //           updatedConfoirmPass: '1234567',
                                    //         );
                                    //       });
                                    //       generalUsersProvider
                                    //           .fetchGeneralUsersList();
                                    //       setState(() {});
                                    //     },
                                    //     icon: Icon(Icons.lock)),

                                    // IconButton(
                                    //     onPressed: () {
                                    //       GeneralUsersRepository().changeUserRole(
                                    //           userId:
                                    //               '${generalUsersProvider.generalUsersList.data![index].id}',
                                    //           updatedRoleId: '4');
                                    //     },
                                    //     icon: Icon(Icons.edit)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
