import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/helpers/constants.dart';
import '../widgets/app_bar_custom.dart';
import '../widgets/custom_stauts_row.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 62),
        child: Column(children: [
          ///app Bar
          Padding(
            padding: EdgeInsets.only(top: 24.0.h, bottom: 54.h),
            child: const AppBarCustom(
              widgetName: 'Status',
            ),
          ),

          ///
          Container(
            padding: EdgeInsetsDirectional.only(
                start: 19.w, top: 20.h, bottom: 20.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.sp),
                color: Colors.white),
            child: Column(
              children: [
                ///Add State
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 19.0.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Status",
                          style: buildAppBarTextStyle(
                              fontSizeController: 16, letterSpacing: 0.15),
                        ),
                        const Icon(
                          Icons.edit_outlined,
                          color: Color(0xffAFAFAF),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 19.h,
                ),

                ///view and select status
                _CustomStatusRowState(
                  statusText: "Inbox",
                  color: kRedColor,
                  index: 0,
                ),
                _CustomStatusRowState(
                  statusText: "Pending",
                  color: kYellowColor,
                  index: 1,
                ),
                _CustomStatusRowState(
                  statusText: "in Progress",
                  color: kLightBlueColor,
                  index: 2,
                ),
                _CustomStatusRowState(
                  statusText: "Completed",
                  color: kGreenColor,
                  index: 3,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  int isSelected = 0;

  int count = 0;

  Widget _CustomStatusRowState(
      {required String statusText, required Color color, required int index}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 19.0.w),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() {
              isSelected = index;
              // count++;
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
                      color: color,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                Text(
                  statusText,
                  style: buildAppBarTextStyle(
                      color: kBlackColor,
                      fontSizeController: 16,
                      letterSpacing: 0.15),
                ),
                const Spacer(),
                isSelected == index
                    ? const Icon(
                        Icons.check,
                        size: 35,
                        color: kLightBlueColor,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          index != 3
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
