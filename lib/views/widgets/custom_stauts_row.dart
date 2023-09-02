import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helpers/constants.dart';

class CustomStatusRow extends StatefulWidget {
  const CustomStatusRow({
    super.key,
    required this.statusText,
    required this.color,
    required this.index,
  });

  final String statusText;
  final Color color;
  final int index;

  @override
  State<CustomStatusRow> createState() => _CustomStatusRowState();
}

class _CustomStatusRowState extends State<CustomStatusRow> {
  bool isSelected = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 19.0.w),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() {
              isSelected = !isSelected;

              count++;
            }),
            child: Row(
              children: [
                Opacity(
                  opacity: 1.0,
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                Text(
                  widget.statusText,
                  style: buildAppBarTextStyle(
                      color: kBlackColor,
                      fontSizeController: 16,
                      letterSpacing: 0.15),
                ),
                const Spacer(),
                isSelected && count < 1
                    ? const Icon(
                        Icons.check,
                        size: 35,
                        color: kLightBlueColor,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          widget.index != 3
              ? Divider(
                  indent: 50.0.w,
                  thickness: 1.2,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
