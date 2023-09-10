import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin MyShowBottomSheet {
  showSheet(BuildContext context, Widget widget) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.r), topLeft: Radius.circular(25.r)),
      ),
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return widget;
      },
    );
  }
}
