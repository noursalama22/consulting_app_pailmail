import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_date_container.dart';
import '../../widgets/custom_text_field.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  DateTime? _selectedDate = DateTime.now();

  static List<String> categories = [
    "Official organization",
    "NGOs",
    "UnBorder",
    "Others"
  ];
  static List<Color> colors = [
    kRedColor,
    kYellowColor,
    kLightBlueColor,
    kGreenColor
  ];
  static List<String> status = ["Inbox", "Pending", "in Progress", "Completed"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              top: 20.0.h, start: 20.w, end: 20.w, bottom: 62.h),
          child: Column(
            children: [
              const CustomAppBar(
                widgetName: 'Filters',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    // CustomListRowState(
                    //   list: categories,
                    //   isStatus: false,
                    // ),
                    // CustomListRowState(
                    //   list: status,
                    //   isStatus: true,
                    //   color: colors,
                    // ),
                  ],
                ),
              ),

              ///date calender
              CustomDateContainer(
                title: 'From Date',
                selectedDate: _selectedDate!,
                isFilterScreen: false,
                archiveWidget: Column(
                  children: [
                    // const CustomDivider(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.archive_outlined,
                          color: kDarkGreyColor,
                          size: 25,
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Expanded(
                          // توسيع الحقل ليحتل العرض المتاح
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Archive Number",
                                style: buildAppBarTextStyle(
                                    color: kBlackColor,
                                    letterSpacing: 0.15,
                                    fontSizeController: 16),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                // استخدم العرض الكامل للشاشة - (عرض الأيقونة + 9 وحدة)
                                child: CustomTextField(
                                  withoutPrefix: true,
                                  paddingHor: 0,
                                  hintText: '2021/2022',
                                  maxLine: null,
                                  customFontSize: 16.0,
                                  controller: null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ), // CustomContainer(
              SizedBox(
                height: 20.h,
              ),

              ///date calender
              CustomDateContainer(
                title: 'From Date',
                selectedDate: _selectedDate!,
                isFilterScreen: false,
                archiveWidget: Column(
                  children: [
                    // const CustomDivider(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.archive_outlined,
                          color: kDarkGreyColor,
                          size: 25,
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Expanded(
                          // توسيع الحقل ليحتل العرض المتاح
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Archive Number",
                                style: buildAppBarTextStyle(
                                    color: kBlackColor,
                                    letterSpacing: 0.15,
                                    fontSizeController: 16),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                // استخدم العرض الكامل للشاشة - (عرض الأيقونة + 9 وحدة)
                                child: CustomTextField(
                                  withoutPrefix: true,
                                  paddingHor: 0,
                                  hintText: '2021/2022',
                                  maxLine: null,
                                  customFontSize: 16.0,
                                  controller: null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ), // CustomContainer(
            ],
          ),
        ),
      ),
    );
  }

// }
}
