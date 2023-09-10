import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/search/search_filters_screen.dart';

class CustomListRowState extends StatefulWidget {
  CustomListRowState(
      {Key? key, required this.list, required this.isStatus, this.color})
      : super(key: key);
  final List<String> list;
  final bool isStatus;
  final List<Color>? color;

  @override
  State<CustomListRowState> createState() => _CustomListRowStateState();
}

class _CustomListRowStateState extends State<CustomListRowState> {
  // final bool isCategory;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CustomRowStateWidget(
            index: index,
            text: widget.list[index],
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            color: widget.color?[index] ?? Colors.black,
            selected: selectedIndex,
            checkTap: true,
            isStatus: widget.isStatus,
          );
        },
        itemCount: widget.list.length,
        shrinkWrap: true,
      ),
    );
  }

  // int selectedStatusIndex = 0;
  toggleSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
