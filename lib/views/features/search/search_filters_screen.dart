import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_date_container.dart';

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
              CustomDateContainer(
                title: 'From Date',
                selectedDate: _selectedDate!,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomDateContainer(
                title: 'To Date',
                selectedDate: _selectedDate!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // }
}
