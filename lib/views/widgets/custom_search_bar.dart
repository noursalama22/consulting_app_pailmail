import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helpers/constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
          top: 4.h, bottom: 4.h, start: 20.w, end: 13.w),
      decoration: BoxDecoration(
          // color: const Color(0xffE6E6E6),
          color: Colors.white,
          borderRadius: BorderRadius.circular(24)),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.zero,
          prefixIcon: const Icon(
            Icons.search,
            size: 30,
            color: kMediumGreyColor,
          ),
          suffixIcon: Transform.scale(
            scale: 0.7, // Adjust the scale factor as needed
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffafafaf),
              ),
              child: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ),
          hintText: "Sport",
          hintStyle:
              buildAppBarTextStyle(fontSizeController: 14, color: kBlackColor),
          focusedBorder: buildOutlineInputBorderTextField(),
          enabledBorder: buildOutlineInputBorderTextField(),
        ),
      ),
    );
  }
}
