import 'package:consulting_app_pailmail/views/widgets/custom_list_row_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/ui_helpers/common_tools.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_date_container.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen>
    with Pickers {
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
              CustomDateContainer(
                title: 'From Date',
                selected_date: _selectedDate!,
                datePickerWidget: buildCalendarDatePicker(_selectedDate!),
              ),
              // CustomContainer(
              //   childContainer: Padding(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              //     child: CustomExpansionTile(
              //       isIndexWidet: true,
              //       widgetOfTile: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           const Icon(
              //             Icons.calendar_month,
              //             color: kRedColor,
              //             size: 25,
              //           ),
              //           SizedBox(
              //             width: 9.w,
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "From Date",
              //                 style: buildAppBarTextStyle(
              //                     color: kBlackColor,
              //                     letterSpacing: 0.15,
              //                     fontSizeController: 16),
              //               ),
              //               Text(
              //                 "$_selectedDate".split(" ")[0],
              //                 style: buildAppBarTextStyle(
              //                     letterSpacing: 0.15, fontSizeController: 12),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //       children: [
              //         buildDivider(),
              //         Column(
              //           children: [
              //             buildCalendarDatePicker(_selectedDate!)
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20.h,
              ),
              CustomDateContainer(
                title: 'To Date',
                selected_date: _selectedDate!,
                datePickerWidget: buildCalendarDatePicker(_selectedDate!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // }
}
