import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helpers/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.widgetName,
      this.bottomPadding = 55,
      this.endPadding = 0,
      this.onTap})
      : super(key: key);
  final String widgetName;
  final double bottomPadding;
  final double endPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: 16.0.h, bottom: bottomPadding, end: endPadding),
      //    padding: EdgeInsetsDirectional.only(top: 24.0.h, bottom: bottomPadding, end: endPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text("Cancel",
                  style: buildAppBarTextStyle(letterSpacing: 1.2))),
          Text(
            widgetName,
            style: buildAppBarTextStyle(color: kBlackColor),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "Done",
              style: buildAppBarTextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
