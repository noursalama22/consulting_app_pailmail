import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class CustomContainerDetails extends StatefulWidget {
  const CustomContainerDetails(
      {super.key,
      required this.organizationName,
      required this.organizationCategory,
      required this.dateOrgName,
      required this.dateOrgCategory,
      required this.subject,
      required this.onPress});

  final String organizationName;
  final String organizationCategory;
  final String dateOrgName;
  final String dateOrgCategory;
  final Widget subject;
  final Function onPress;

  @override
  State<CustomContainerDetails> createState() => _CustomContainerDetailsState();
}

class _CustomContainerDetailsState extends State<CustomContainerDetails> {
  double? Hight;

  @override
  Widget build(BuildContext context) {
    //Todo:Modification  Container
    return Container(
      // width: 378.w,
      // height: 190.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30.r),
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 12.0, end: 5, top: 4),
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: kGreyWhiteColor,
                            size: 20,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.organizationName,
                                  style: tileTextTitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Text(
                                widget.organizationCategory,
                                style: tileTextNumberStyle.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.dateOrgName,
                        style: tileTextNumberStyle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Arch ${widget.dateOrgCategory}",
                        style: tileTextNumberStyle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                height: 12.h,
                thickness: 1,
                color: kLightGreyColor,
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 3.0, end: 3),
                child: widget.subject,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
