import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helpers/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.widgetName,
      this.bottomPadding = 55,
      this.endPadding = 0})
      : super(key: key);
  final String widgetName;
  final double bottomPadding;
  final double endPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: 24.0.h, bottom: bottomPadding, end: endPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Cancel", style: buildAppBarTextStyle()),
          Text(
            widgetName,
            style: buildAppBarTextStyle(color: kBlackColor),
          ),
          Text(
            "Done",
            style: buildAppBarTextStyle(),
          ),
        ],
      ),
    );
  }
}
