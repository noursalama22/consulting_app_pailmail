import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/providers/general_users_provider.dart';
import 'package:consulting_app_pailmail/repositories/general_users_repository.dart';
import 'package:consulting_app_pailmail/views/features/home/drawer/settings/general_user_profile.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_profile_photo_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                CustomAppBar(
                  widgetName: 'user_management'.tr(),
                  bottomPadding: 32,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Consumer<GeneralUsersProvider>(
                      builder: (_, generalUsersProvider, __) {
                        if (generalUsersProvider.generalUsersList.status ==
                            ApiStatus.LOADING) {
                          // return const Center(
                          //   child: spinkit,
                          return Center(
                            child: Skeletonizer(
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 16.h,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: 8,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    padding: EdgeInsetsDirectional.symmetric(
                                        horizontal: 24.w, vertical: 16.h),
                                    decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(
                                            size: 40,
                                            Icons.account_circle,
                                            color: kDarkGreyColor,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'user name',
                                              ),
                                              Text(
                                                'email',
                                              )
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                            color: kPrimaryBlueColor
                                                .withOpacity(0.1),
                                          ),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.delete),
                                            color: kRedColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
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
                            return SizedBox(
                              height: 16.h,
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
                                    horizontal: 24.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Row(
                                  children: [
                                    user.image != null
                                        ? CustomProfilePhotoContainer(
                                            image:
                                                'https://palmail.gsgtt.tech/storage/${user.image}',
                                            raduis: 40,
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(
                                              size: 40,
                                              Icons.account_circle,
                                              color: kDarkGreyColor,
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
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
                                    ),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        color:
                                            kPrimaryBlueColor.withOpacity(0.1),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          bool isDeleted =
                                              await GeneralUsersRepository()
                                                  .deleteGeneralUser(
                                            userId:
                                                '${generalUsersProvider.generalUsersList.data![index].id}',
                                          );
                                          isDeleted
                                              ? Provider.of<
                                                          GeneralUsersProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchGeneralUsersList()
                                              : null;
                                          //  setState(() {});
                                        },
                                        icon: Icon(Icons.delete),
                                        color: kRedColor,
                                      ),
                                    )
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
