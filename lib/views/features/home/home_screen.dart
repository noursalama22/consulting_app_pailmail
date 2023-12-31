import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/models/mails/mail.dart';
import 'package:consulting_app_pailmail/providers/auth_provider.dart';
import 'package:consulting_app_pailmail/providers/categories_provider.dart';
import 'package:consulting_app_pailmail/providers/status_provider.dart';
import 'package:consulting_app_pailmail/providers/tag_provider.dart';
import 'package:consulting_app_pailmail/repositories/auth_repository.dart';
import 'package:consulting_app_pailmail/storage/shared_prefs.dart';
import 'package:consulting_app_pailmail/views/features/all_category_mails.dart';
import 'package:consulting_app_pailmail/views/features/tags/tags_screen.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_category_container.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_chip.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_expansion_tile.dart';
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
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/routers/router.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/show_bottom_sheet.dart';
import '../inbox_mails/inbox_screen.dart';
import 'drawer/custom_drawer_content.dart';

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

  bool isEn = true;
  // bool isAr = false;

  void changeLanguage() async {
    isEn = !isEn;
    isEn
        ? await context.setLocale(const Locale('en'))
        : await context.setLocale(const Locale('ar'));
    setState(() {});
    Future.delayed(const Duration(seconds: 2), () {
      NavigationRoutes().pushUntil(context, Routes.splash_screen);
    });
  }

  Color hexToColor(String hexString, {String alphaChannel = 'ff'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
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
    // print('$imageUrl${SharedPrefrencesController().image}');

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

  navigateToAllMail(List<Mail> mails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AllCategoryMails(
            mailsList: mails,
          );
        },
      ),
    );
  }

  String fetchOrgName(int index) {
    switch (index) {
      case 0:
        return "officialOrganizations";
      case 1:
        return "ngos";
      case 2:
        return "foreign";
      case 3:
        return "other";
      default:
        return "";
    }
  }

  ///TODO :Handle error widget
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
      rtlOpening: context.locale.toString() == 'en' ? false : true,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Scaffold(
        //   TODO :SLIVER APP BAR WITH TITLE
        //   TODO :Animation
        //TODO :add widget comment for work of widget

        bottomNavigationBar: SharedPrefrencesController().roleName != 'user'
            ? Material(
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
                        InboxScreen(
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
              )
            : SizedBox(),
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

                        child: authProvider.currentUser.data?.user.image == null
                            ? const Icon(
                                Icons.account_circle,
                                size: 50,
                              )
                            : CustomProfilePhotoContainer(
                                image:
                                    '$imageUrl/${authProvider.currentUser.data?.user.image}',
                                raduis: 50,
                              ),

                        // child: CustomProfilePhotoContainer(
                        //   image: '${SharedPrefrencesController().image}',
                        //   raduis: 50.r,
                        // ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.profile_screen),
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 24.w, vertical: 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // CustomFdeImage(
                                //     userImage:
                                //         '$imageUrl${SharedPrefrencesController().image}'),
                                // Image.network(
                                //     '$imageUrl${SharedPrefrencesController().image}'),
                                // CustomProfilePhotoContainer(
                                //   image:
                                //       '$imageUrl${SharedPrefrencesController().image}',
                                //   raduis: 90.r,
                                // ),

                                authProvider.currentUser.data?.user.image ==
                                        null
                                    ? const Icon(
                                        Icons.account_circle,
                                        size: 90,
                                        color: kLightGreyColor,
                                      )
                                    : CustomProfilePhotoContainer(
                                        image:
                                            '$imageUrl/${authProvider.currentUser.data?.user.image}',
                                        raduis: 90.r,
                                      ),
                                Text(
                                  SharedPrefrencesController().name,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 16.sp),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  SharedPrefrencesController().roleName,
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
                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            //   Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (_) => LoginScreen()));
                            //   setState(() {});
                            // });
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
                              child: Consumer<StatusProvider>(builder:
                                  (BuildContext context, StatusProvider value,
                                      Widget? child) {
                                //  var data = value.allStatus.data![0];
                                return CustomMailCategoryContainer(
                                  endMargin: 16.w,
                                  number: value.allStatus.status ==
                                              ApiStatus.LOADING ||
                                          value.allStatus.status ==
                                              ApiStatus.ERROR
                                      ? ""
                                      : value.allStatus.data![0].mailsCount!,
                                  onTap: () {
                                    Provider.of<StatusProvider>(context,
                                            listen: false)
                                        .fetchSingleStatus(id: "1")
                                        .then((value) {
                                      var stauts = Provider.of<StatusProvider>(
                                              context,
                                              listen: false)
                                          .singleStatus;

                                      if (stauts.status ==
                                          ApiStatus.COMPLETED) {
                                        var mails = stauts.data!.mails;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AllCategoryMails(
                                              isCateogry: false,
                                              mailsList: mails,
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  text: "inbox".tr(),
                                  color: kRedColor,
                                );
                              }),
                            ),
                            Expanded(
                              child: Consumer<StatusProvider>(builder:
                                  (BuildContext context, StatusProvider value,
                                      Widget? child) {
                                //  var data = value.allStatus.data![0];
                                return CustomMailCategoryContainer(
                                  number: value.allStatus.status ==
                                              ApiStatus.LOADING ||
                                          value.allStatus.status ==
                                              ApiStatus.ERROR
                                      ? ""
                                      : value.allStatus.data![1].mailsCount!,
                                  onTap: () {
                                    Provider.of<StatusProvider>(context,
                                            listen: false)
                                        .fetchSingleStatus(id: "2")
                                        .then((value) {
                                      var stauts = Provider.of<StatusProvider>(
                                              context,
                                              listen: false)
                                          .singleStatus;

                                      //  print("**************$mails");
                                      if (stauts.status ==
                                          ApiStatus.COMPLETED) {
                                        var mails = stauts.data!.mails;
                                        //   print("**************$mails");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AllCategoryMails(
                                              isCateogry: false,
                                              mailsList: mails,
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  text: "pending".tr(),
                                  color: kYellowColor,
                                );
                              }),
                            ),
                          ],
                          // mainAxisAlignment: MainAxisAlignment.end,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Consumer<StatusProvider>(builder:
                                  (BuildContext context, StatusProvider value,
                                      Widget? child) {
                                //  var data = value.allStatus.data![0];
                                return CustomMailCategoryContainer(
                                  endMargin: 16.w,
                                  number: value.allStatus.status ==
                                              ApiStatus.LOADING ||
                                          value.allStatus.status ==
                                              ApiStatus.ERROR
                                      ? ""
                                      : value.allStatus.data![2].mailsCount!,
                                  onTap: () {
                                    Provider.of<StatusProvider>(context,
                                            listen: false)
                                        .fetchSingleStatus(id: "3")
                                        .then((value) {
                                      var stauts = Provider.of<StatusProvider>(
                                              context,
                                              listen: false)
                                          .singleStatus;

                                      //  print("**************$mails");
                                      if (stauts.status ==
                                          ApiStatus.COMPLETED) {
                                        var mails = stauts.data!.mails;
                                        //   print("**************$mails");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AllCategoryMails(
                                              isCateogry: false,
                                              mailsList: mails,
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  text: "inProgress".tr(),
                                  color: kLightBlueColor,
                                );
                              }),
                            ),
                            Expanded(
                              child: Consumer<StatusProvider>(builder:
                                  (BuildContext context, StatusProvider value,
                                      Widget? child) {
                                //  var data = value.allStatus.data![0];
                                return CustomMailCategoryContainer(
                                  number: value.allStatus.status ==
                                              ApiStatus.LOADING ||
                                          value.allStatus.status ==
                                              ApiStatus.ERROR
                                      ? ""
                                      : value.allStatus.data![3].mailsCount!,
                                  onTap: () {
                                    Provider.of<StatusProvider>(context,
                                            listen: false)
                                        .fetchSingleStatus(id: "4")
                                        .then((value) {
                                      var stauts = Provider.of<StatusProvider>(
                                              context,
                                              listen: false)
                                          .singleStatus;

                                      //  print("**************$mails");
                                      if (stauts.status ==
                                          ApiStatus.COMPLETED) {
                                        var mails = stauts.data!.mails;
                                        //   print("**************$mails");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AllCategoryMails(
                                              isCateogry: false,
                                              mailsList: mails,
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  text: "completed".tr(),
                                  color: kGreenColor,
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24.h,
                        ),

                        Consumer<CategoriesProvider>(builder:
                            (BuildContext context, CategoriesProvider value,
                                Widget? child) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              if (value.mailsCategory[index].status ==
                                  ApiStatus.LOADING) {
                                return const Skeletonizer(
                                  //todo:
                                  enabled: true,
                                  child: ListTile(
                                    title: Text('Item number  as title'),
                                    // subtitle: Text('Subtitle here'),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 32,
                                    ),
                                  ),
//                                   mailNumber: data!.length.toString(),
//                                   children: [
//                                     ListView.builder(
//                                       itemBuilder: (context, index) {
//                                         return CustomMailContainer(
//                                           onTap: () {
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                               builder: (context) {
//                                                 return InboxScreen(
//                                                   isDetails: true,
//                                                   mail: data[index],
//                                                   IsSender: false,
//                                                 );
//                                               },
//                                             ));
//                                           },
//                                           organizationName:
//                                               data[index].sender!.name ?? "",
//                                           color: hexToColor(
//                                               data[index].status!.color ?? ''),
//                                           date: data[index].archiveDate ?? "",
//                                           description:
//                                               data[index].description ?? "",
//                                           images: const [],
//                                           tags: data[index].tags ?? [],
//                                           subject: data[index].subject ?? "",
//                                           endMargin: 8,
//                                         );
//                                       },
//                                       shrinkWrap: true,
//                                       itemCount:
//                                           data.length < 3 ? data.length : 3,
//                                     ),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     data.length > 3
//                                         ? Padding(
//                                             padding: const EdgeInsetsDirectional
//                                                 .only(end: 10),
//                                             child: GestureDetector(
//                                               onTap: () =>
//                                                   navigateToAllMail(data),
//                                               child: const Align(
//                                                 child: Text(
//                                                   'See More',
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     color: kLightBlueColor,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 alignment: AlignmentDirectional
//                                                     .centerEnd,
//                                               ),
//                                             ),
//                                           )
//                                         : const SizedBox.shrink(),
//                                   ],
                                );
                              } else if (value.mailsCategory[index].status ==
                                  ApiStatus.ERROR) {
                                const Text("SomeThing Wrong :(");
                              } else {
                                var data = value.mailsCategory[index].data!;
                                return CustomExpansionTile(
                                    index: index,
                                    isEmpty: true,
                                    widgetOfTile: Text(
                                      fetchOrgName(index).tr(),
                                      style: tileTextTitleStyle,
                                    ),

//                                     mailNumber: '',
//                                     isEmpty: true,
//                                     children: const [
//                                       Column(
//                                         children: [
//                                           Icon(Icons.warning),
//                                           Text("No Data")
//                                         ],
//                                       ),
//                                     ]);
//                               } else {
//                                 var data = value.mailsCategory[1].data;
//                                 return CustomExpansionTile(
//                                   index: 1,
//                                   widgetOfTile: Text(
//                                     "ngos".tr(),
//                                     style: tileTextTitleStyle,
//                                   ),
//                                   mailNumber: data!.length.toString(),
//                                   children: [
//                                     ListView.builder(
//                                       itemBuilder: (context, index) {
//                                         return CustomMailContainer(
//                                           onTap: () {
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                               builder: (context) {
//                                                 return InboxScreen(
//                                                   isDetails: true,
//                                                   mail: data[index],
//                                                   IsSender: false,

                                    mailNumber:
                                        value.mailsCategory[index].data!.isEmpty
                                            ? '0'
                                            : data!.length.toString(),
                                    children: value
                                            .mailsCategory[index].data!.isEmpty
                                        ? const [
                                            Column(
                                              children: [
                                                Icon(Icons.warning),
                                                Text("No Mails")
                                              ],
                                            ),
                                          ]
                                        : [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              // physics:
                                              //     NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return CustomMailContainer(
                                                  onTap: () {
                                                    print(
                                                        "**********************${data[index].attachments!.length}");
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return InboxScreen(
                                                          isDetails: true,
                                                          mail: data[index],
                                                          IsSender: false,
                                                        );
                                                      },
                                                    )).then((value) {
                                                      print(
                                                          "lllllllllllllllllllll&$value");
                                                      Provider.of<CategoriesProvider>(
                                                              context,
                                                              listen: false)
                                                          .fetchCategoryMails(
                                                              categoryId: "2",
                                                              index: 0);
                                                      Provider.of<CategoriesProvider>(
                                                              context,
                                                              listen: false)
                                                          .fetchCategoryMails(
                                                              categoryId: "3",
                                                              index: 1);
                                                      Provider.of<CategoriesProvider>(
                                                              context,
                                                              listen: false)
                                                          .fetchCategoryMails(
                                                              categoryId: "4",
                                                              index: 2);
                                                      Provider.of<CategoriesProvider>(
                                                              context,
                                                              listen: false)
                                                          .fetchCategoryMails(
                                                              categoryId: "1",
                                                              index: 3);
                                                    });
                                                    Provider.of<CategoriesProvider>(
                                                            context,
                                                            listen: false)
                                                        .mailsCategory;
                                                    setState(() {});
                                                  },
                                                  organizationName: data[index]
                                                          .sender!
                                                          .name ??
                                                      "",
                                                  color: hexToColor(data[index]
                                                          .status!
                                                          .color ??
                                                      ''),
                                                  date:
                                                      data[index].archiveDate ??
                                                          "",
                                                  description:
                                                      data[index].description ??
                                                          "",
                                                  images:
                                                      data[index].attachments ??
                                                          [],
                                                  tags: data[index].tags ?? [],
                                                  subject:
                                                      data[index].subject ?? "",
                                                  endMargin: 8,
                                                );
                                              },
                                              itemCount: data.length < 3
                                                  ? data.length
                                                  : 3,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            data.length > 3
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(end: 10),
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          navigateToAllMail(
                                                              data),
                                                      child: const Align(
                                                        child: Text(
                                                          'See More',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                kLightBlueColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerEnd,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ]);
                              }
                            },
                            itemCount: 4,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                          );
                        }),

                        SizedBox(
                          height: 15.h,
                        ),

//TODO
                        Consumer<TagProvider>(
                          builder: (context, value, child) {
                            if (value.tagList.status == ApiStatus.LOADING ||
                                value.tagList.status == ApiStatus.ERROR) {
                              return SizedBox.shrink();
                            } else {
                              if (value.tagList.data!.isEmpty) {
                                return SizedBox.shrink();
                              } else {
                                var tags = value.tagList.data!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.symmetric(
                                          horizontal: 20.w),
                                      child: Text(
                                        "tags".tr(),
                                        style: tileTextTitleStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14.h,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
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
                                            isHomeTag: true,
                                            text: "allTags".tr(),
                                            onPressed: () {
                                              Provider.of<TagProvider>(context,
                                                      listen: false)
                                                  .getTagWithMailList("all");
                                              // var tag =
                                              //     Provider.of<TagProvider>(
                                              //             context,
                                              //             listen: true)
                                              //         .tagWithMailList;
                                              // print("${tag.status}");
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return TagsScreen(
                                                    selectedTag: -1,
                                                    tags: tags,
                                                    navFromHome: true,
                                                  );
                                                },
                                              ));
                                            },
                                          ),
                                          for (int i = 0;
                                              i < tags.length;
                                              i++) ...{
                                            CustomChip(
                                                text: "${tags[i].name}",
                                                isHomeTag: true,
                                                onPressed: () {
                                                  Provider.of<TagProvider>(
                                                          context,
                                                          listen: false)
                                                      .getTagWithMailList(
                                                          "[${tags[i].id}]");
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return TagsScreen(
                                                        selectedTag: tags[i].id,
                                                        tags: tags,
                                                        navFromHome: true,
                                                      );
                                                    },
                                                  ));
                                                }),
                                          }
                                        ],
                                      ),
//                                     ]);
//                               } else {
//                                 var data = value.mailsCategory[3].data;
//                                 return CustomExpansionTile(
//                                   index: 3,
//                                   widgetOfTile: Text(
//                                     "other".tr(),
//                                     style: tileTextTitleStyle,
//                                   ),
//                                   mailNumber: data!.length.toString(),
//                                   children: [
//                                     ListView.builder(
//                                       itemBuilder: (context, index) {
//                                         return CustomMailContainer(
//                                           onTap: () {
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                               builder: (context) {
//                                                 return InboxScreen(
//                                                   isDetails: true,
//                                                   mail: data[index],
//                                                   IsSender: false,
//                                                 );
//                                               },
//                                             ));
//                                           },
//                                           organizationName:
//                                               data[index].sender!.name ?? "",
//                                           color: hexToColor(
//                                               data[index].status!.color ?? ''),
//                                           date: data[index].archiveDate ?? "",
//                                           description:
//                                               data[index].description ?? "",
//                                           images: const [], //TODO:display Images
//                                           tags: data[index].tags ?? [],
//                                           subject: data[index].subject ?? "",
//                                           endMargin: 8,
//                                         );
//                                       },
//                                       itemCount:
//                                           data.length < 3 ? data.length : 3,
//                                       shrinkWrap: true,
//                                     ),
//                                     const SizedBox(
//                                       height: 8,
                                    ),
                                  ],
                                );
                              }
                            }
                          },
                        ),
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
