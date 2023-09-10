import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helpers/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_expansion_tile.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  DateTime? _selectedDate = DateTime.now();
  int isCategorySelected = 0;
  int isStatusSelected = 0;
  bool checkCategory = false;
  bool checkStatus = false;
  toggleSelection(int index, bool isCategory) {
    setState(() {
      if (isCategory == true) {
        isCategorySelected = index;
        checkCategory = true;
      } else {
        isStatusSelected = index;
        checkStatus = true;
      }
    });
  }

  List<String> categories = [
    "Official organization",
    "NGOs",
    "UnBorder",
    "Others"
  ];
  @override
  void initState() {
    toggleSelection(0, true);
    toggleSelection(0, false);
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      ///  category
                      // _CustomCategoryRowState(
                      //   statusText: "Official organization",
                      //   index: 0,
                      // ),
                      CustomRowStateWidget(
                        index: 0,
                        statusText: 'Official organization',
                        onTap: () {
                          setState(() {
                            toggleSelection(0, true);
                          });
                        },
                        selected: isCategorySelected,
                        condition: checkCategory,
                        isStatus: false,
                      ),
                      CustomRowStateWidget(
                        index: 1,
                        statusText: 'NGOs',
                        onTap: () {
                          setState(() {
                            toggleSelection(1, true);
                          });
                        },
                        selected: isCategorySelected,
                        condition: checkCategory,
                        isStatus: false,
                      ),
                      CustomRowStateWidget(
                        index: 2,
                        statusText: 'UnBorder',
                        onTap: () {
                          setState(() {
                            toggleSelection(2, true);
                          });
                        },
                        selected: isCategorySelected,
                        condition: checkCategory,
                        isStatus: false,
                      ),
                      CustomRowStateWidget(
                        index: 3,
                        statusText: 'Others',
                        onTap: () {
                          setState(() {
                            toggleSelection(3, true);
                          });
                        },
                        selected: isCategorySelected,
                        condition: checkCategory,
                        isStatus: false,
                      ),
                      // _CustomCategoryRowState(
                      //   statusText: "NGOs",
                      //   index: 1,
                      // ),
                      // _CustomCategoryRowState(
                      //   statusText: "UnBorder",
                      //   index: 2,
                      // ),
                      // _CustomCategoryRowState(
                      //   statusText: "Others",
                      //   index: 3,
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 19.w, top: 20.h, bottom: 20.h),
                margin: EdgeInsetsDirectional.symmetric(
                  vertical: 20.h,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.sp),
                    color: Colors.white),
                child: Column(
                  children: [
                    ///view and select status
                    CustomRowStateWidget(
                      index: 0,
                      statusText: 'Inbox',
                      onTap: () {
                        setState(() {
                          toggleSelection(0, false);
                        });
                      },
                      color: kRedColor,
                      selected: isStatusSelected,
                      condition: checkStatus,
                      isStatus: true,
                    ),
                    CustomRowStateWidget(
                      index: 1,
                      statusText: 'Pending',
                      onTap: () {
                        setState(() {
                          toggleSelection(1, false);
                        });
                      },
                      color: kYellowColor,
                      selected: isStatusSelected,
                      condition: checkStatus,
                      isStatus: true,
                    ),
                    CustomRowStateWidget(
                      index: 2,
                      statusText: 'in Progress',
                      onTap: () {
                        setState(() {
                          toggleSelection(2, false);
                        });
                      },
                      color: kLightBlueColor,
                      selected: isStatusSelected,
                      condition: checkStatus,
                      isStatus: true,
                    ),
                    CustomRowStateWidget(
                      index: 3,
                      statusText: 'Completed',
                      onTap: () {
                        setState(() {
                          toggleSelection(3, false);
                        });
                      },
                      color: kGreenColor,
                      selected: isStatusSelected,
                      condition: checkStatus,
                      isStatus: true,
                    ),
                    // _CustomStatusRowState(
                    //   statusText: "Inbox",
                    //   color: kRedColor,
                    //   index: 0,
                    // ),
                    // _CustomStatusRowState(
                    //   statusText: "Pending",
                    //   color: kYellowColor,
                    //   index: 1,
                    // ),
                    // _CustomStatusRowState(
                    //   statusText: "in Progress",
                    //   color: kLightBlueColor,
                    //   index: 2,
                    // ),
                    // _CustomStatusRowState(
                    //   statusText: "Completed",
                    //   color: kGreenColor,
                    //   index: 3,
                    // ),
                  ],
                ),
              ),
              CustomContainer(
                childContainer: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: CustomExpansionTile(
                    isIndexWidet: true,
                    widgetOfTile: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: kRedColor,
                          size: 25,
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "From Date",
                              style: buildAppBarTextStyle(
                                  color: kBlackColor,
                                  letterSpacing: 0.15,
                                  fontSizeController: 16),
                            ),
                            Text(
                              "$_selectedDate".split(" ")[0],
                              style: buildAppBarTextStyle(
                                  letterSpacing: 0.15, fontSizeController: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      buildDivider(),
                      Column(
                        children: [buildCalendarDatePicker()],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomContainer(
                childContainer: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: CustomExpansionTile(
                    isIndexWidet: true,
                    widgetOfTile: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: kRedColor,
                          size: 25,
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "To Date",
                              style: buildAppBarTextStyle(
                                  color: kBlackColor,
                                  letterSpacing: 0.15,
                                  fontSizeController: 16),
                            ),
                            Text(
                              "$_selectedDate".split(" ")[0],
                              style: buildAppBarTextStyle(
                                  letterSpacing: 0.15, fontSizeController: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      buildDivider(),
                      Column(
                        children: [buildCalendarDatePicker()],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CalendarDatePicker buildCalendarDatePicker() {
    return CalendarDatePicker(
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      onDateChanged: (value) {
        // _selectedDate = value;
        if (_selectedDate != null && value != _selectedDate) {
          setState(() {
            _selectedDate = value;
          });
        }
      },
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 12,
      thickness: 1.5,
      indent: 17.w,
      endIndent: 16.w,
    );
  }

  int count = 0;
  // Widget _CustomStatusRowState(
  //     {required String statusText, required Color color, required int index}) {
  //   return Column(
  //     children: [
  //       InkWell(
  //         onTap: () => setState(() {
  //           isStatusSelected = index;
  //         }),
  //         child: Row(
  //           children: [
  //             Opacity(
  //               opacity: 1.0,
  //               child: Container(
  //                 margin: const EdgeInsets.only(right: 16),
  //                 width: 32.w,
  //                 height: 32.w,
  //                 decoration: BoxDecoration(
  //                   color: color,
  //                   borderRadius: BorderRadius.circular(10.r),
  //                 ),
  //               ),
  //             ),
  //             Text(
  //               statusText,
  //               style: buildAppBarTextStyle(
  //                   color: kBlackColor,
  //                   fontSizeController: 16,
  //                   letterSpacing: 0.15),
  //             ),
  //             const Spacer(),
  //             isStatusSelected == index
  //                 ? Padding(
  //                     padding: EdgeInsetsDirectional.only(end: 19.0.w),
  //                     child: const Icon(
  //                       Icons.check,
  //                       size: 35,
  //                       color: kLightBlueColor,
  //                     ),
  //                   )
  //                 : const SizedBox.shrink(),
  //           ],
  //         ),
  //       ),
  //       index != 3
  //           ? Divider(
  //               indent: 50.0.w,
  //               thickness: 1.2,
  //             )
  //           : const SizedBox.shrink()
  //     ],
  //   );
  // }
  //
  // Widget _CustomCategoryRowState(
  //     {required String statusText, required int index}) {
  //   return CustomContainer(
  //       childContainer: Padding(
  //     padding: index != 2
  //         ? EdgeInsetsDirectional.only(start: 18.h)
  //         : EdgeInsets.zero,
  //     child: Column(
  //       children: [
  //         InkWell(
  //           onTap: () => setState(() {
  //             isCategorySelected = index;
  //           }),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 8.0),
  //             child: Row(
  //               children: [
  //                 Padding(
  //                   padding: index == 2
  //                       ? EdgeInsetsDirectional.only(start: 18.0)
  //                       : EdgeInsets.zero,
  //                   child: Text(
  //                     statusText,
  //                     style: buildAppBarTextStyle(
  //                         color: kBlackColor,
  //                         fontSizeController: 16,
  //                         letterSpacing: 0.15),
  //                   ),
  //                 ),
  //                 const Spacer(),
  //                 isCategorySelected == index
  //                     ? Padding(
  //                         padding: EdgeInsetsDirectional.only(end: 19.0.w),
  //                         child: const Icon(
  //                           Icons.check,
  //                           size: 30,
  //                           color: kLightBlueColor,
  //                         ),
  //                       )
  //                     : const SizedBox.shrink(),
  //               ],
  //             ),
  //           ),
  //         ),
  //         index != 3 && index != 2
  //             ? Divider(
  //                 indent: 8.0.w,
  //                 thickness: 1.2,
  //               )
  //             : const SizedBox.shrink(),
  //         index == 2
  //             ? const Divider(
  //                 thickness: 1.7,
  //               )
  //             : const SizedBox.shrink()
  //       ],
  //     ),
  //   ));
  // }
}

class CustomRowStateWidget extends StatelessWidget {
  final int index;
  final String statusText;
  final Function() onTap;
  final int selected;
  final bool condition;
  final Color? color;
  final bool isStatus;
  const CustomRowStateWidget(
      {Key? key,
      required this.index,
      required this.statusText,
      required this.onTap,
      required this.selected,
      required this.condition,
      this.color,
      required this.isStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        childContainer: Padding(
      padding: index != 2 && isStatus == false
          ? EdgeInsetsDirectional.only(start: 18.h)
          : EdgeInsets.zero,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  isStatus == true
                      ? Container(
                          margin: const EdgeInsets.only(right: 16),
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: index == 2
                        ? EdgeInsetsDirectional.only(start: 18.0)
                        : EdgeInsets.zero,
                    child: Text(
                      statusText,
                      style: buildAppBarTextStyle(
                          color: kBlackColor,
                          fontSizeController: 16,
                          letterSpacing: 0.15),
                    ),
                  ),
                  const Spacer(),
                  condition == true && selected == index
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(end: 19.0.w),
                          child: const Icon(
                            Icons.check,
                            size: 30,
                            color: kLightBlueColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          index != 3 && index != 2
              ? Divider(
                  indent: 8.0.w,
                  thickness: 1.2,
                )
              : const SizedBox.shrink(),
          index == 2
              ? const Divider(
                  thickness: 1.7,
                )
              : const SizedBox.shrink()
        ],
      ),
    ));
  }
}
