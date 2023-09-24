import 'package:consulting_app_pailmail/core/helpers/routers/router.dart';
import 'package:consulting_app_pailmail/repositories/sender_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class CustomAppBarWithIcon extends StatefulWidget {
  const CustomAppBarWithIcon(
      {Key? key,
      required this.widgetName,
      required this.left_icon,
      required this.right_icon,
      this.bottomPadding = 55,
      this.endPadding = 0,
      required this.id})
      : super(key: key);
  final String widgetName;
  final double bottomPadding;
  final double endPadding;
  final IconData left_icon;
  final IconData right_icon;
  final String? id;

  @override
  State<CustomAppBarWithIcon> createState() => _CustomAppBarWithIconState();
}

class _CustomAppBarWithIconState extends State<CustomAppBarWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: 16.0.h, bottom: widget.bottomPadding, end: widget.endPadding),
      //    padding: EdgeInsetsDirectional.only(top: 24.0.h, bottom: bottomPadding, end: endPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(widget.left_icon, color: kLightBlueColor))
          // Text("Cancel", style: buildAppBarTextStyle()),
          ,
          Text(widget.widgetName,
              style: buildAppBarTextStyle(color: kBlackColor)),
          GestureDetector(
            child: Icon(
              widget.right_icon,
              color: kLightBlueColor,
            ),
            onTap: () {
              _show(context, widget.widgetName, widget.id!);
            },
          )

          // Text(
          //   "Done",
          //   style: buildAppBarTextStyle(),
          // ),
        ],
      ),
    );
  }
}

void _show(BuildContext ctx, String title, String id) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      context: ctx,
      builder: (ctx) => Container(
            height: 270.h,
            width: 428.w,
            decoration: BoxDecoration(
                color: kLightGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: buildAppBarTextStyle(color: kBlackColor),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: kGreyWhiteColor),
                        child: InkWell(
                          onTap: () => Navigator.pop(ctx),
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 112.w,
                        height: 103.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kWhiteColor),
                        child: Padding(
                          padding: REdgeInsetsDirectional.all(33.h),
                          child: Column(
                            children: [
                              Icon(
                                Icons.archive,
                                color: kDarkGreyColor,
                              ),
                              Text("archive"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 112.w,
                        height: 103.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kWhiteColor),
                        child: Padding(
                          padding: REdgeInsetsDirectional.all(33.h),
                          child: Column(
                            children: [
                              Icon(
                                Icons.share,
                                color: kLightBlueColor,
                              ),
                              Text("share"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 112.w,
                        height: 103.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kWhiteColor),
                        child: Padding(
                          padding: REdgeInsetsDirectional.all(33.h),
                          child: InkWell(
                            onTap: () {
                              SenderRepository repository = SenderRepository();
                              repository.deleteSender(id);
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: kRedColor,
                                ),
                                Text("delete"),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ));
}
