import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';
import 'custom_container.dart';

class CustomRowStateWidget extends StatelessWidget {
  final int index;
  final String text;
  final Function() onTap;
  final int selected;
  final bool checkTap;
  final Color? color;
  final bool isStatus;
  const CustomRowStateWidget(
      {Key? key,
      required this.index,
      required this.text,
      required this.onTap,
      required this.selected,
      required this.checkTap,
      this.color,
      required this.isStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        childContainer: Padding(
      padding: index != 2 && isStatus == false
          ? EdgeInsetsDirectional.only(start: 18.h)
          : EdgeInsets.zero,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  isStatus == true
                      ? Container(
                          margin: const EdgeInsets.only(right: 16),
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: index == 2 && !isStatus
                        ? const EdgeInsetsDirectional.only(start: 18.0)
                        : EdgeInsets.zero,
                    child: Text(
                      text,
                      style: buildAppBarTextStyle(
                          color: kBlackColor,
                          fontSizeController: 16,
                          letterSpacing: 0.15),
                    ),
                  ),
                  const Spacer(),
                  checkTap == true && selected == index
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(end: 19.0.w),
                          child: const Icon(
                            Icons.check,
                            size: 30,
                            color: kLightBlueColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          isStatus
              ? index != 3
                  ? Divider(
                      indent: 50.0.w,
                      thickness: 1.2,
                    )
                  : const SizedBox.shrink()
              : index != 3 && index != 2
                  ? Divider(
                      indent: 8.0.w,
                      thickness: 1.2,
                    )
                  : const SizedBox.shrink(),
          index == 2 && !isStatus
              ? const Divider(
                  thickness: 1.7,
                )
              : const SizedBox.shrink()
        ],
      ),
    ));
  }
}
