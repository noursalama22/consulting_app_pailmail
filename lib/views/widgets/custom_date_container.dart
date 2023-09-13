import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';
import 'custom_container.dart';
import 'custom_divider.dart';
import 'custom_expansion_tile.dart';

class CustomDateContainer extends StatelessWidget {
  final String title;
  final Widget datePickerWidget;
  DateTime selected_date;
  CustomDateContainer({
    super.key,
    required this.title,
    required this.selected_date,
    required this.datePickerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      childContainer: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                    title,
                    style: buildAppBarTextStyle(
                        color: kBlackColor,
                        letterSpacing: 0.15,
                        fontSizeController: 16),
                  ),
                  Text(
                    "$selected_date".split(" ")[0],
                    style: buildAppBarTextStyle(
                        letterSpacing: 0.15, fontSizeController: 12),
                  ),
                ],
              ),
            ],
          ),
          children: [
            CustomDivider(),
            Column(
              children: [datePickerWidget],
            ),
          ],
        ),
      ),
    );
  }
}
