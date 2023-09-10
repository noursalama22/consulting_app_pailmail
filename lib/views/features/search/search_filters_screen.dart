import 'package:consulting_app_pailmail/views/widgets/custom_list_row_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_expansion_tile.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  DateTime? _selectedDate = DateTime.now();

  List<String> categories = [
    "Official organization",
    "NGOs",
    "UnBorder",
    "Others"
  ];
  List<Color> colors = [kRedColor, kYellowColor, kLightBlueColor, kGreenColor];
  List<String> status = ["Inbox", "Pending", "in Progress", "Completed"];
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
                    CustomListRowState(
                      list: categories,
                      isStatus: false,
                    ),
                    CustomListRowState(
                      list: status,
                      isStatus: true,
                      color: colors,
                    ),
                  ],
                ),
              ),

              // Container(
              //   padding: EdgeInsetsDirectional.only(
              //       start: 19.w, top: 20.h, bottom: 20.h),
              //   margin: EdgeInsetsDirectional.symmetric(
              //     vertical: 20.h,
              //   ),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30.sp),
              //       color: Colors.white),
              //   child: Column(
              //     children: [
              //       ///view and select status
              //       CustomRowStateWidget(
              //         index: 0,
              //         text: 'Inbox',
              //         onTap: () {
              //           setState(() {
              //             toggleSelection(0, false);
              //           });
              //         },
              //         color: kRedColor,
              //         selected: selectedStatusIndex,
              //         checkTap: checkStatus,
              //         isStatus: true,
              //       ),
              //       CustomRowStateWidget(
              //         index: 1,
              //         text: 'Pending',
              //         onTap: () {
              //           setState(() {
              //             toggleSelection(1, false);
              //           });
              //         },
              //         color: kYellowColor,
              //         selected: selectedStatusIndex,
              //         checkTap: checkStatus,
              //         isStatus: true,
              //       ),
              //       CustomRowStateWidget(
              //         index: 2,
              //         text: 'in Progress',
              //         onTap: () {
              //           setState(() {
              //             toggleSelection(2, false);
              //           });
              //         },
              //         color: kLightBlueColor,
              //         selected: selectedStatusIndex,
              //         checkTap: checkStatus,
              //         isStatus: true,
              //       ),
              //       CustomRowStateWidget(
              //         index: 3,
              //         text: 'Completed',
              //         onTap: () {
              //           setState(() {
              //             toggleSelection(3, false);
              //           });
              //         },
              //         color: kGreenColor,
              //         selected: selectedStatusIndex,
              //         checkTap: checkStatus,
              //         isStatus: true,
              //       ),
              //     ],
              //   ),
              // ),
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
}

class CustomRowStateWidget extends StatelessWidget {
  final int index;
  final String text;
  final Function() onTap;
  final int selected;
  final bool checkTap;
  final Color? color;
  final bool isStatus;
  const CustomRowStateWidget(
      {Key? key,
      required this.index,
      required this.text,
      required this.onTap,
      required this.selected,
      required this.checkTap,
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
                    padding: index == 2 && !isStatus
                        ? EdgeInsetsDirectional.only(start: 18.0)
                        : EdgeInsets.zero,
                    child: Text(
                      text,
                      style: buildAppBarTextStyle(
                          color: kBlackColor,
                          fontSizeController: 16,
                          letterSpacing: 0.15),
                    ),
                  ),
                  const Spacer(),
                  checkTap == true && selected == index
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
          isStatus
              ? index != 3
                  ? Divider(
                      indent: 50.0.w,
                      thickness: 1.2,
                    )
                  : const SizedBox.shrink()
              : index != 3 && index != 2
                  ? Divider(
                      indent: 8.0.w,
                      thickness: 1.2,
                    )
                  : const SizedBox.shrink(),
          index == 2 && !isStatus
              ? const Divider(
                  thickness: 1.7,
                )
              : const SizedBox.shrink()
        ],
      ),
    ));
  }
}
