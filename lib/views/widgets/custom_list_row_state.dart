import 'package:consulting_app_pailmail/models/categories/category_response_model.dart';
import 'package:consulting_app_pailmail/providers/categories_provider.dart';

import 'package:consulting_app_pailmail/models/statuses/status.dart';
import 'package:consulting_app_pailmail/providers/status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'custom_row_state_widget.dart';

class CustomListRowState<T> extends StatefulWidget {
  CustomListRowState(
      {Key? key,
      this.list,
      this.statusList,
      required this.isStatus,
      this.color})
      : super(key: key);
  final List<CategoryElement>? list;
  final List<Status>? statusList;
  //2 before API_Cat
  // final List<String> list;

  final bool isStatus;
  final List<Status>? color;

  @override
  State<CustomListRowState> createState() => _CustomListRowStateState();
}

class _CustomListRowStateState extends State<CustomListRowState> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex =
        Provider.of<StatusProvider>(context, listen: true).index;

    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CustomRowStateWidget(
            index: index,
            text: widget.isStatus
                ? widget.statusList![index].name!
                : widget.list![index].name!,
            //3 before API_Cat
            // text: widget.list[index],
            onTap: () {
              setState(() {
                selectedIndex = index;
                widget.isStatus
                    ? Provider.of<StatusProvider>(context, listen: false)
                        .changeStatus(selectedIndex: selectedIndex)
                    : Provider.of<CategoriesProvider>(context, listen: false)
                        .changeSelectedCategory(selectedIndex: selectedIndex);
              });
            },
            color: widget.isStatus
                ? Color(int.parse(widget.color![index].color.toString()))
                : null,
            selected: selectedIndex,
            checkTap: true,
            isStatus: widget.isStatus,
          );
        },
        // itemCount: widget.list != null || widget.statusList != null
        //     ? widget.isStatus
        //         ? widget.statusList!.length
        //         : widget.list!.length
        //     : 0,
        itemCount:
            widget.isStatus ? widget.statusList!.length : widget.list!.length,

        shrinkWrap: true,
      ),
    );
  }

  // int selectedStatusIndex = 0;
  // toggleSelection(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }
}
