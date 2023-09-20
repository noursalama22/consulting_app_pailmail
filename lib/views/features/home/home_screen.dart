import 'package:cached_network_image/cached_network_image.dart';
import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/providers/auth_provider.dart';
import 'package:consulting_app_pailmail/providers/categories_provider.dart';
import 'package:consulting_app_pailmail/repositories/auth_repository.dart';
import 'package:consulting_app_pailmail/storage/shared_prefs.dart';
import 'package:consulting_app_pailmail/views/features/all_category_mails.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_category_container.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_chip.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_expansion_tile.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_fade_image.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_profile_photo_container.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_status_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/routers/router.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/show_bottom_sheet.dart';
import '../../widgets/custom_drawer_content.dart';
import '../inbox_mails/inbox_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with MyShowBottomSheet {
  // RoleRepository roleRepository = RoleRepository();
  AuthRepository authRepository = AuthRepository();
  AuthProvider authProvider = AuthProvider();

  final _advancedDrawerController = AdvancedDrawerController();

  late ScrollController _scrollViewController;
  bool _showTextAppbar = false;
  bool isScrollingDown = true;

  bool isEn = false;

  void changeLanguage() {
    setState(() {
      isEn = !isEn;
      isEn
          ? context.setLocale(const Locale('en'))
          : context.setLocale(const Locale('ar'));
    });
    Navigator.pop(context);
  }

  void _handleMenuButtonPressed() {
    // Manage Advanced Drawer state through the Controller.
    _advancedDrawerController.showDrawer();
  }

  @override
  void initState() {
    super.initState();
    // roleRepository.fetchRoleList();
    authRepository.fetchCurrentUser();
    print('$imageUrl${SharedPrefrencesController().image}');

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _showTextAppbar = true;

        setState(() {});
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_scrollViewController.position.atEdge) {
          _showTextAppbar = false;
        } else {
          _showTextAppbar = true;
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  navigateToAllMail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AllCategoryMails(index: index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: kGradient,
        ),
      ),
      drawer: const SafeArea(
        child: CustomDrawerContent(),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: isEn ? false : true,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Scaffold(
        //   TODO :SLIVER APP BAR WITH TITLE
        //   TODO :Animation
        //TODO :add widget comment for work of widget

        bottomNavigationBar: Material(
          color: Colors.white,
          shape: Border(
              top: BorderSide(
            color: kLightGreyColor,
            width: 1.w,
          )),
          child: InkWell(
            onTap: () {
              //print('called on tap');
              showSheet(
                  context,
                  const InboxScreen(
                    isDetails: false,
                  ));
            },
            child: SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 20.w),
                child: Row(
                  children: [
                    const CustomStatusContainer(
                      color: kLightBlueColor,
                      size: 24,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "newInbox".tr(),
                      style: tileTextTitleStyle.copyWith(
                        color: kLightBlueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              AnimatedContainer(
                decoration: BoxDecoration(
                  border: _showTextAppbar
                      ? Border(
                          bottom:
                              BorderSide(color: kLightGreyColor, width: 2.w))
                      : const Border(),
                ),
                // height: _showAppbar ? 56.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: AppBar(
                  centerTitle: true,
                  title: _showTextAppbar
                      ? Text(
                          "palMail".tr(),
                          style: const TextStyle(color: Colors.black),
                        )
                      : const SizedBox(),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: _handleMenuButtonPressed,
                    icon: ValueListenableBuilder<AdvancedDrawerValue>(
                      valueListenable: _advancedDrawerController,
                      builder: (_, value, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            value.visible ? Icons.clear : Icons.menu,
                            key: ValueKey<bool>(value.visible),
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        NavigationRoutes().jump(context, Routes.search_screen,
                            replace: false);
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    PopupMenuButton<Widget>(
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.only(end: 18.0, top: 4),

                        // child: CustomProfilePhotoContainer(
                        //   image:
                        //       '$imageUrl/${authProvider.currentUser.data?.user.image}',
                        //   raduis: 50,
                        // ),

                        child: CustomProfilePhotoContainer(
                          image: '${SharedPrefrencesController().image}',
                          raduis: 50.r,
                        ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 24.w, vertical: 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomFdeImage(
                                    userImage:
                                        '$imageUrl${SharedPrefrencesController().image}'),
                                // Image.network(
                                //     '$imageUrl${SharedPrefrencesController().image}'),
                                // CustomProfilePhotoContainer(
                                //   image:
                                //       '$imageUrl${SharedPrefrencesController().image}',
                                //   raduis: 90.r,
                                // ),
                                // CustomProfilePhotoContainer(
                                //   image:
                                //       '$imageUrl/${authProvider.currentUser.data?.user.image}',
                                //   raduis: 90.r,
                                // ),
                                Text(
                                  '${SharedPrefrencesController().name}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 16.sp),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${SharedPrefrencesController().roleName}',
                                  style: GoogleFonts.poppins(
                                      color: kMediumGreyColor, fontSize: 12.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          //TODO : Custom Widget for rows
                          child: InkWell(
                            onTap: changeLanguage,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  color: Colors.grey.shade600,
                                  size: 30.sp,
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text(
                                  "language".tr(),
                                  style: statusTextStyle.copyWith(
                                      color: kDarkGreyColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () async {
                            await authProvider.logout();
                            await SharedPrefrencesController().clear();
                            NavigationRoutes()
                                .pushUntil(context, Routes.login_screen);
                          },
                          //TODO : Custom Widget for rows
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.grey.shade600,
                                size: 30.sp,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text(
                                'logout'.tr(),
                                style: statusTextStyle.copyWith(
                                    color: kDarkGreyColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollViewController,
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 20.0.w, vertical: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomMailCategoryContainer(
                                endMargin: 16.w,
                                number: 9,
                                onTap: () {
//TODO : Add fn
                                },
                                text: "inbox_mails".tr(),
                                color: kRedColor,
                              ),
                            ),
                            Expanded(
                              child: CustomMailCategoryContainer(
                                  color: kYellowColor,
                                  number: 9,
                                  onTap: () {
//TODO : Add fn
                                  },
                                  text: "pending".tr()),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomMailCategoryContainer(
                                  color: kLightBlueColor,
                                  endMargin: 16.w,
                                  number: 9,
                                  onTap: () {
//TODO : Add fn
                                  },
                                  text: "inProgress".tr()),
                            ),
                            Expanded(
                              child: CustomMailCategoryContainer(
                                  color: kGreenColor,
                                  number: 9,
                                  onTap: () {
//TODO : Add fn
                                  },
                                  text: "completed".tr()),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        //Consumer 1
                        Consumer<CategoriesProvider>(
                          builder: (BuildContext context,
                              CategoriesProvider value, Widget? child) {
                            if (value.mailsCategory[0].status ==
                                ApiStatus.LOADING) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (value.mailsCategory[0].status ==
                                ApiStatus.COMPLETED) {
                              if (value.mailsCategory[0].data!.isEmpty) {
                                return CustomExpansionTile(
                                    index: 0,
                                    widgetOfTile: Text(
                                      "officialOrganizations".tr(),
                                      // "officialOrganizations".tr(),
                                      style: tileTextTitleStyle,
                                    ),
                                    mailNumber: '',
                                    isEmpty: true,
                                    children: const [
                                      Column(
                                        children: [
                                          Icon(Icons.warning),
                                          Text("No Data")
                                        ],
                                      ),
                                    ]);
                              } else {
                                var data = value.mailsCategory[0].data;
                                return CustomExpansionTile(
                                  index: 0,
                                  widgetOfTile: Text(
                                    "officialOrganizations".tr(),
                                    // "officialOrganizations".tr(),
                                    style: tileTextTitleStyle,
                                  ),
                                  mailNumber: data!.length.toString(),
                                  children: [
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return CustomMailContainer(
                                          onTap: () {},
                                          organizationName:
                                              data![index].sender!.name ?? "",
                                          color: kYellowColor,
                                          date: data![index].archiveDate ?? "",
                                          description:
                                              data![index].description ?? "",
                                          images: const [],
                                          tags: data![index].tags ?? [],
                                          subject: data![index].subject ?? "",
                                          endMargin: 8,
                                        );
                                      },
                                      shrinkWrap: true,
                                      itemCount:
                                          data!.length < 3 ? data!.length : 3,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    data!.length > 3
                                        ? Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 10),
                                            child: GestureDetector(
                                              onTap: () => navigateToAllMail(0),
                                              child: const Align(
                                                child: Text(
                                                  'See More',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: kLightBlueColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                );
                              }
                            }
                            return Text(
                                value.mailsCategory[0].message.toString());
                          },
                        ),
                        //Consumer 2
                        Consumer<CategoriesProvider>(
                          builder: (BuildContext context,
                              CategoriesProvider value, Widget? child) {
                            if (value.mailsCategory[1].status ==
                                ApiStatus.LOADING) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (value.mailsCategory[1].status ==
                                ApiStatus.COMPLETED) {
                              if (value.mailsCategory[1].data!.isEmpty) {
                                return CustomExpansionTile(
                                    index: 0,
                                    widgetOfTile: Text(
                                      "NGOs".tr(),
                                      // "officialOrganizations".tr(),
                                      style: tileTextTitleStyle,
                                    ),
                                    mailNumber: '',
                                    isEmpty: true,
                                    children: const [
                                      Column(
                                        children: [
                                          Icon(Icons.warning),
                                          Text("No Data")
                                        ],
                                      ),
                                    ]);
                              } else {
                                var data = value.mailsCategory[1].data;
                                return CustomExpansionTile(
                                  index: 1,
                                  widgetOfTile: Text(
                                    "NGOs".tr(),
                                    style: tileTextTitleStyle,
                                  ),
                                  mailNumber: data!.length.toString(),
                                  children: [
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return CustomMailContainer(
                                          onTap: () {},
                                          organizationName:
                                              data![index].sender!.name ?? "",
                                          color: kYellowColor,
                                          date: data![index].archiveDate ?? "",
                                          description:
                                              data![index].description ?? "",
                                          images:
                                              data![index].attachments ?? [],
                                          tags: data![index].tags ?? [],
                                          subject: data![index].subject ?? "",
                                          endMargin: 8,
                                        );
                                      },
                                      itemCount:
                                          data!.length < 3 ? data!.length : 3,
                                      shrinkWrap: true,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    data!.length > 3
                                        ? Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 10),
                                            child: GestureDetector(
                                              onTap: () => navigateToAllMail(1),
                                              child: const Align(
                                                child: Text(
                                                  'See More',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: kLightBlueColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                );
                              }
                            }
                            return Text(
                                value.mailsCategory[1].message.toString());
                          },
                        ),
                        //Consumer 3
                        Consumer<CategoriesProvider>(
                          builder: (BuildContext context,
                              CategoriesProvider value, Widget? child) {
                            if (value.mailsCategory[2].status ==
                                ApiStatus.LOADING) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (value.mailsCategory[2].status ==
                                ApiStatus.COMPLETED) {
                              if (value.mailsCategory[2].data!.isEmpty) {
                                return CustomExpansionTile(
                                    index: 0,
                                    isEmpty: true,
                                    widgetOfTile: Text(
                                      "Foreign".tr(),
                                      // "officialOrganizations".tr(),
                                      style: tileTextTitleStyle,
                                    ),
                                    mailNumber: '0',
                                    children: const [
                                      Column(
                                        children: [
                                          Icon(Icons.warning),
                                          Text("No Mails")
                                        ],
                                      ),
                                    ]);
                              } else {
                                var data = value.mailsCategory[2].data;
                                return CustomExpansionTile(
                                  index: 2,
                                  widgetOfTile: Text(
                                    "Foreign".tr(),
                                    style: tileTextTitleStyle,
                                  ),
                                  mailNumber: data!.length.toString(),
                                  children: [
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return CustomMailContainer(
                                          onTap: () {},
                                          organizationName:
                                              data![index].sender!.name ?? "",
                                          color: kYellowColor,
                                          date: data![index].archiveDate ?? "",
                                          description:
                                              data![index].description ?? "",
                                          images: const [],
                                          tags: data![index].tags ?? [],
                                          subject: data![index].subject ?? "",
                                          endMargin: 8,
                                        );
                                      },
                                      itemCount:
                                          data!.length < 3 ? data!.length : 3,
                                      shrinkWrap: true,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    data!.length > 3
                                        ? Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 10),
                                            child: GestureDetector(
                                              onTap: () => navigateToAllMail(2),
                                              child: const Align(
                                                child: Text(
                                                  'See More',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: kLightBlueColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                );
                              }
                            }
                            return Text(
                                value.mailsCategory[2].message.toString());
                          },
                        ),
                        //Consumer 4
                        Consumer<CategoriesProvider>(
                          builder: (BuildContext context,
                              CategoriesProvider value, Widget? child) {
                            if (value.mailsCategory[3].status ==
                                ApiStatus.LOADING) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (value.mailsCategory[3].status ==
                                ApiStatus.COMPLETED) {
                              if (value.mailsCategory[3].data!.isEmpty) {
                                return CustomExpansionTile(
                                    index: 0,
                                    isEmpty: true,
                                    widgetOfTile: Text(
                                      "Foreign".tr(),
                                      // "officialOrganizations".tr(),
                                      style: tileTextTitleStyle,
                                    ),
                                    mailNumber: '0',
                                    children: const [
                                      Column(
                                        children: [
                                          Icon(Icons.warning),
                                          Text("No Mails")
                                        ],
                                      ),
                                    ]);
                              } else {
                                var data = value.mailsCategory[3].data;
                                return CustomExpansionTile(
                                  index: 3,
                                  widgetOfTile: Text(
                                    "Other".tr(),
                                    style: tileTextTitleStyle,
                                  ),
                                  mailNumber: data!.length.toString(),
                                  children: [
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return CustomMailContainer(
                                          onTap: () {},
                                          organizationName:
                                              data![index].sender!.name ?? "",
                                          color: kYellowColor,
                                          date: data![index].archiveDate ?? "",
                                          description:
                                              data![index].description ?? "",
                                          images: const [], //TODO:display Images
                                          tags: data![index].tags ?? [],
                                          subject: data![index].subject ?? "",
                                          endMargin: 8,
                                        );
                                      },
                                      itemCount:
                                          data!.length < 3 ? data!.length : 3,
                                      shrinkWrap: true,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    data!.length > 3
                                        ? Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 10),
                                            child: GestureDetector(
                                              onTap: () => navigateToAllMail(3),
                                              child: const Align(
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                                child: Text(
                                                  'See More',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: kLightBlueColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                );
                              }
                            }
                            return Text(
                                value.mailsCategory[3].message.toString());
                          },
                        ),
                        // Consumer<CategoriesProvider>(
                        //   builder: (BuildContext context,
                        //       CategoriesProvider value, Widget? child) {
                        //     if (value.mailsCategory1.status ==
                        //         ApiStatus.LOADING) {
                        //       return const Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     }
                        //     if (value.mailsCategory1.status ==
                        //         ApiStatus.COMPLETED) {
                        //       if (value.mailsCategory1.data!.isEmpty) {
                        //         return const Column(
                        //           children: [
                        //             Icon(Icons.warning),
                        //             Text("No Data")
                        //           ],
                        //         );
                        //       } else {
                        //         var data = value.mailsCategory1.data;
                        //         return CustomExpansionTile(
                        //             widgetOfTile: Text(
                        //               "officialOrganizations".tr(),
                        //               // "officialOrganizations".tr(),
                        //               style: tileTextTitleStyle,
                        //             ),
                        //             mailNumber: data!.length.toString(),
                        //             children: [
                        //               ListView.builder(
                        //                 itemBuilder: (context, index) {
                        //                   return CustomMailContainer(
                        //                     onTap: () {},
                        //                     organizationName:
                        //                         data![index].sender!.name ?? "",
                        //                     color: kYellowColor,
                        //                     date:
                        //                         data![index].archiveDate ?? "",
                        //                     description:
                        //                         data![index].description ?? "",
                        //                     images: [],
                        //                     tags: data![index].tags ?? [],
                        //                     subject: data![index].subject ?? "",
                        //                     endMargin: 8,
                        //                   );
                        //                 },
                        //                 shrinkWrap: true,
                        //                 itemCount: data!.length ?? 0,
                        //               )
                        //             ]);
                        //       }
                        //     }
                        //     return Text(
                        //         value.mailsCategory1.message.toString());
                        //   },
                        // ),
                        // Consumer<CategoriesProvider>(
                        //   builder: (BuildContext context,
                        //       CategoriesProvider value, Widget? child) {
                        //     if (value.mailsCategory2.status ==
                        //         ApiStatus.LOADING) {
                        //       return const Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     }
                        //     if (value.mailsCategory2.status ==
                        //         ApiStatus.COMPLETED) {
                        //       if (value.mailsCategory2.data!.isEmpty) {
                        //         return const Column(
                        //           children: [
                        //             Icon(Icons.warning),
                        //             Text("No Data")
                        //           ],
                        //         );
                        //       } else {
                        //         var data = value.mailsCategory2.data;
                        //         return CustomExpansionTile(
                        //           widgetOfTile: Text(
                        //             "NGOs".tr(),
                        //             style: tileTextTitleStyle,
                        //           ),
                        //           mailNumber: data!.length.toString(),
                        //           children: [
                        //             ListView.builder(
                        //               itemBuilder: (context, index) {
                        //                 return CustomMailContainer(
                        //                   onTap: () {},
                        //                   organizationName:
                        //                       data![index].sender!.name ?? "",
                        //                   color: kYellowColor,
                        //                   date: data![index].archiveDate ?? "",
                        //                   description:
                        //                       data![index].description ?? "",
                        //                   images: [],
                        //                   tags: data![index].tags ?? [],
                        //                   subject: data![index].subject ?? "",
                        //                   endMargin: 8,
                        //                 );
                        //               },
                        //               itemCount: data!.length ?? 0,
                        //               shrinkWrap: true,
                        //             )
                        //           ],
                        //         );
                        //       }
                        //     }
                        //     return Text(
                        //         value.mailsCategory2.message.toString());
                        //   },
                        // ),
                        // Consumer<CategoriesProvider>(
                        //   builder: (BuildContext context,
                        //       CategoriesProvider value, Widget? child) {
                        //     if (value.mailsCategory3.status ==
                        //         ApiStatus.LOADING) {
                        //       return const Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     }
                        //     if (value.mailsCategory3.status ==
                        //         ApiStatus.COMPLETED) {
                        //       if (value.mailsCategory3.data!.isEmpty) {
                        //         return const Column(
                        //           children: [
                        //             Icon(Icons.warning),
                        //             Text("No Data")
                        //           ],
                        //         );
                        //       } else {
                        //         var data = value.mailsCategory3.data;
                        //         return CustomExpansionTile(
                        //           widgetOfTile: Text(
                        //             "Foreign".tr(),
                        //             style: tileTextTitleStyle,
                        //           ),
                        //           mailNumber: data!.length.toString(),
                        //           children: [
                        //             ListView.builder(
                        //               itemBuilder: (context, index) {
                        //                 return CustomMailContainer(
                        //                   onTap: () {},
                        //                   organizationName:
                        //                       data![index].sender!.name ?? "",
                        //                   color: kYellowColor,
                        //                   date: data![index].archiveDate ?? "",
                        //                   description:
                        //                       data![index].description ?? "",
                        //                   images: [],
                        //                   tags: data![index].tags ?? [],
                        //                   subject: data![index].subject ?? "",
                        //                   endMargin: 8,
                        //                 );
                        //               },
                        //               itemCount: data!.length ?? 0,
                        //               shrinkWrap: true,
                        //             )
                        //           ],
                        //         );
                        //       }
                        //     }
                        //     return Text(
                        //         value.mailsCategory3.message.toString());
                        //   },
                        // ),
                        // Consumer<CategoriesProvider>(
                        //   builder: (BuildContext context,
                        //       CategoriesProvider value, Widget? child) {
                        //     if (value.mailsCategory4.status ==
                        //         ApiStatus.LOADING) {
                        //       return const Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     }
                        //     if (value.mailsCategory3.status ==
                        //         ApiStatus.COMPLETED) {
                        //       if (value.mailsCategory4.data!.isEmpty) {
                        //         return const Column(
                        //           children: [
                        //             Icon(Icons.warning),
                        //             Text("No Data")
                        //           ],
                        //         );
                        //       } else {
                        //         var data = value.mailsCategory4.data;
                        //         return CustomExpansionTile(
                        //           widgetOfTile: Text(
                        //             "Other".tr(),
                        //             style: tileTextTitleStyle,
                        //           ),
                        //           mailNumber: data!.length.toString(),
                        //           children: [
                        //             ListView.builder(
                        //               itemBuilder: (context, index) {
                        //                 return CustomMailContainer(
                        //                   onTap: () {},
                        //                   organizationName:
                        //                       data![index].sender!.name ?? "",
                        //                   color: kYellowColor,
                        //                   date: data![index].archiveDate ?? "",
                        //                   description:
                        //                       data![index].description ?? "",
                        //                   images: [],
                        //                   tags: data![index].tags ?? [],
                        //                   subject: data![index].subject ?? "",
                        //                   endMargin: 8,
                        //                 );
                        //               },
                        //               itemCount: data!.length ?? 0,
                        //               shrinkWrap: true,
                        //             )
                        //           ],
                        //         );
                        //       }
                        //     }
                        //     return Text(
                        //         value.mailsCategory4.message.toString());
                        //   },
                        // ),
                        // CustomExpansionTile(
                        //   widgetOfTile: Text(
                        //     "officialOrganizations".tr(),
                        //     style: tileTextTitleStyle,
                        //   ),
                        //   mailNumber: "6",
                        //   children: [
                        //     CustomMailContainer(
                        //       onTap: () {},
                        //       organizationName: 'Organization Name',
                        //       color: kYellowColor,
                        //       date: "Today, 11:00 AM",
                        //       description:
                        //           "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                        //       images: [],
                        //       tags: [
                        //         "urgent",
                        //         "new",
                        //         "water",
                        //       ],
                        //       subject: "Here we add the subject",
                        //       endMargin: 8,
                        //     ),
                        //     CustomMailContainer(
                        //       onTap: () {},
                        //       organizationName: 'Organization Name',
                        //       color: kGreenColor,
                        //       date: "Today, 11:00 AM",
                        //       description:
                        //           "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                        //       images: [],
                        //       tags: [],
                        //       subject: "Here we add the subject",
                        //     ),
                        //   ],
                        // ),
                        // CustomExpansionTile(
                        //   widgetOfTile: Text(
                        //     "ngos".tr(),
                        //     style: tileTextTitleStyle,
                        //   ),
                        //   mailNumber: "12",
                        //   children: [
                        //     CustomMailContainer(
                        //       onTap: () {},
                        //       organizationName: 'Organization Name',
                        //       color: kYellowColor,
                        //       date: "Today, 11:00 AM",
                        //       description:
                        //           "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                        //       images: [],
                        //       tags: [],
                        //       subject: "Here we add the subject",
                        //     )
                        //   ],
                        // ),
                        // CustomExpansionTile(
                        //   widgetOfTile: Text(
                        //     "foreign".tr(),
                        //     style: tileTextTitleStyle,
                        //   ),
                        //   mailNumber: "6",
                        //   children: [
                        //     CustomMailContainer(
                        //       onTap: () {},
                        //       organizationName: 'Organization Name',
                        //       color: kYellowColor,
                        //       date: "Today, 11:00 AM",
                        //       description:
                        //           "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                        //       images: [],
                        //       tags: [],
                        //       subject: "Here we add the subject",
                        //     )
                        //   ],
                        // ),
                        // CustomExpansionTile(
                        //   widgetOfTile: Text(
                        //     "other".tr(),
                        //     style: tileTextTitleStyle,
                        //   ),
                        //   mailNumber: "3",
                        //   children: [
                        //     CustomMailContainer(
                        //       onTap: () {},
                        //       organizationName: 'Organization Name',
                        //       color: kYellowColor,
                        //       date: "Today, 11:00 AM",
                        //       description:
                        //           "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                        //       images: [],
                        //       tags: [],
                        //       subject: "Here we add the subject",
                        //     )
                        //   ],
                        // ),

                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                          child: Text(
                            "tags".tr(),
                            style: tileTextTitleStyle,
                          ),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
//TODO
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: Wrap(
                            //TODO:Hnadle move to tag screen
                            spacing: 6,
                            children: [
                              CustomChip(
                                text: "allTags".tr(),
                                onPressed: () {},
                              ),
                              CustomChip(text: '#Urgent', onPressed: () {}),
                              CustomChip(
                                  text: '#Egyptian Military', onPressed: () {}),
                              CustomChip(text: '#New', onPressed: () {}),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Scaffold(
      //   TODO :SLIVER APP BAR WITH TITLE
      //  TODO : add more icon
      //  TODO : use .h .w fr sizes
      //  TODO : Modify image
      //   TODO :Animation
      appBar: AppBar(
        centerTitle: true,
        title: _showTextAppbar
            ? Text(
                "pal_mail".tr(),
                style: TextStyle(color: Colors.black),
              )
            : SizedBox(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Image.asset(
          'assets/images/menu.png',
          // width: 32,
          // height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          PopupMenuButton<Widget>(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 18.0),
              child: CustomProfilePhotoContainer(
                image: 'assets/images/user_photo.png',
                raduis: 36,
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CustomProfilePhotoContainer(
                        image: 'assets/images/user_photo.png',
                        raduis: 90,
                      ),
                      Text(
                        "User name",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "admin",
                        style: GoogleFonts.poppins(
                            color: kMediumGreyColor, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                //TODO : Custom Widget for rows
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'English',
                      style: statusTextStyle.copyWith(color: kDarkGreyColor),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                //TODO : Custom Widget for rows
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Logout',
                      style: statusTextStyle.copyWith(color: kDarkGreyColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: Material(
        color: Colors.white,
        shape: Border(
            top: BorderSide(
          color: kLightGreyColor,
          width: 1,
        )),
        child: InkWell(
          onTap: () {
            //print('called on tap');
          },
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Row(
                children: [
                  const CustomStatusContainer(
                    color: kLightBlueColor,
                    size: 24,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "new_inbox".tr(),
                    style: tileTextTitleStyle.copyWith(
                      color: kLightBlueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        //TODO: ADD SEARCH TEXT FIELD
        controller: _scrollViewController,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 20.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomMailCategoryContainer(
                      endMargin: 16,
                      number: 9,
                      onTap: () {
//TODO : Add fn
                      },
                      text: "inbox_mails".tr(),
                      color: kRedColor,
                    ),
                  ),
                  Expanded(
                    child: CustomMailCategoryContainer(
                        color: kYellowColor,
                        number: 9,
                        onTap: () {
//TODO : Add fn
                        },
                        text: "pending".tr()),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomMailCategoryContainer(
                        color: kLightBlueColor,
                        endMargin: 16,
                        number: 9,
                        onTap: () {
//TODO : Add fn
                        },
                        text: "in_progress".tr()),
                  ),
                  Expanded(
                    child: CustomMailCategoryContainer(
                        color: kGreenColor,
                        number: 9,
                        onTap: () {
//TODO : Add fn
                        },
                        text: "completed".tr()),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              CustomExpansionTile(
                orgName: "official_organizations".tr(),
                mailNumber: "6",
                children: const [
                  CustomMailContainer(
                    organizationName: 'Organization Name',
                    color: kYellowColor,
                    date: "Today, 11:00 AM",
                    description:
                        "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                    images: [],
                    tags: [
                      "urgent",
                      "new",
                      "water",
                    ],
                    subject: "Here we add the subject",
                    endMargin: 8,
                  ),
                  CustomMailContainer(
                    organizationName: 'Organization Name',
                    color: kGreenColor,
                    date: "Today, 11:00 AM",
                    description:
                        "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                    images: [],
                    tags: [],
                    subject: "Here we add the subject",
                  ),
                ],
              ),
              CustomExpansionTile(
                orgName: "ngos".tr(),
                mailNumber: "12",
                children: const [
                  CustomMailContainer(
                    organizationName: 'Organization Name',
                    color: kYellowColor,
                    date: "Today, 11:00 AM",
                    description:
                        "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                    images: [],
                    tags: [],
                    subject: "Here we add the subject",
                  )
                ],
              ),
              CustomExpansionTile(
                orgName: "foreign".tr(),
                mailNumber: "6",
                children: const [
                  CustomMailContainer(
                    organizationName: 'Organization Name',
                    color: kYellowColor,
                    date: "Today, 11:00 AM",
                    description:
                        "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                    images: [],
                    tags: [],
                    subject: "Here we add the subject",
                  )
                ],
              ),
              CustomExpansionTile(
                orgName: "other".tr(),
                mailNumber: "3",
                children: const [
                  CustomMailContainer(
                    organizationName: 'Organization Name',
                    color: kYellowColor,
                    date: "Today, 11:00 AM",
                    description:
                        "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                    images: [],
                    tags: [],
                    subject: "Here we add the subject",
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
                child: Text(
                  "tags".tr(),
                  style: tileTextTitleStyle,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
//TODO
              Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: Wrap(
//    runSpacing: 8,
                  spacing: 6,
                  children: [
                    CustomChip(
                      text: "all_tags".tr(),
                    ),
                    CustomChip(
                      text: '#Urgent',
                    ),
                    CustomChip(
                      text: '#Egyptian Military',
                    ),
                    CustomChip(
                      text: '#New',
                    ),
// onSelected: (sel) {},
// selected: true,
// selectedColor: kLightBlueColor,
//   color: MaterialStateColor.resolveWith((states) {
//     if (states.contains(MaterialState.selected)) {
//       return kLightBlueColor;
//     }
//     return kLightGreyColor;
//
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
 */
