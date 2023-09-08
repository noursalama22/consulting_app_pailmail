import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_category_container.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_chip.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_expansion_tile.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_profile_photo_container.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_status_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../widgets/custom_drawer_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  late ScrollController _scrollViewController;
  bool _showTextAppbar = false;
  bool isScrollingDown = true;

  void _handleMenuButtonPressed() {
    // Manage Advanced Drawer state through the Controller.
    _advancedDrawerController.showDrawer();
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        print("r");
        // print(
        //     "pos: ${_scrollViewController.position.minScrollExtent} :${_scrollViewController.offset}");
        // if (_scrollViewController.position.atEdge) {
        //   _showTextAppbar = false;
        // } else {
        //   _showTextAppbar = true;
        // }
        _showTextAppbar = true;
        // _showTextAppbar = _scrollViewController.position.minScrollExtent ? false : true;
        //   if (!isScrollingDown) {
        //     isScrollingDown = true;
        //    _showTextAppbar = true;
        setState(() {});
        // }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        print("f");

        //    if(_scrollViewController.position.)
        //  if (_scrollViewController.position.atEdge  ) {
        // _showTextAppbar = false;
        //       } else {
        if (_scrollViewController.position.atEdge) {
          _showTextAppbar = false;
        } else {
          _showTextAppbar = true;
        }
        setState(() {});
        //    }
        // if (isScrollingDown) {
        //   isScrollingDown = false;
        //   _showTextAppbar = true;
        //   setState(() {});
        // }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: kGradient,
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: CustomDrawerContent(),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(22)),
      ),
      child: Scaffold(
        //   TODO :SLIVER APP BAR WITH TITLE
        //  TODO : add more icon
        //  TODO : use .h .w fr sizes
        //  TODO : Modify image
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
                          "pal_mail".tr(),
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
                          duration: Duration(milliseconds: 250),
                          child: Icon(
                            value.visible ? Icons.clear : Icons.menu,
                            key: ValueKey<bool>(value.visible),
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ),

                  // Image.asset(
                  //   'assets/images/menu.png',
                  //   // width: 32,
                  //   // height: 32,
                  // ),
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
                      child: const Padding(
                        padding: EdgeInsetsDirectional.only(end: 18.0),
                        child: CustomProfilePhotoContainer(
                          image: 'assets/images/user_photo.png',
                          raduis: 36,
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
                                CustomProfilePhotoContainer(
                                  image: 'assets/images/user_photo.png',
                                  raduis: 90.r,
                                ),
                                Text(
                                  "User name",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 16.sp),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "admin",
                                  style: GoogleFonts.poppins(
                                      color: kMediumGreyColor, fontSize: 12.sp),
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
                                size: 30.sp,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text(
                                'English',
                                style: statusTextStyle.copyWith(
                                    color: kDarkGreyColor),
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
                                size: 30.sp,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text(
                                'Logout',
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
                                text: "inbox".tr(),
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
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomExpansionTile(
                          widgetOfTile: Text("official_organizations".tr()),
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
                          widgetOfTile: Text("ngos".tr()),
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
                          widgetOfTile: Text("foreign".tr()),
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
                          widgetOfTile: Text("other".tr()),
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
                      text: "inbox".tr(),
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
