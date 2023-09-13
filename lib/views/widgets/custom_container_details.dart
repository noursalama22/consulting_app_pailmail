import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/helpers/constants.dart';

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
  final String subject;
  final Function onPress;

  @override
  State<CustomContainerDetails> createState() => _CustomContainerDetailsState();
}

class _CustomContainerDetailsState extends State<CustomContainerDetails> {
  @override
  Widget build(BuildContext context) {
    //Todo:Modification  Container
    return Container(
      margin: EdgeInsetsDirectional.only(
        bottom: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(30.r),
          onTap: () {},
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ////icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 15.0, end: 8),
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: kGreyWhiteColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Name org....
                            Text(
                              widget.organizationName,
                              style:
                                  tileTextTitleStyle.copyWith(fontSize: 16.sp),
                            ),
                            SizedBox(
                              width: 70.w,
                            ),
                            Text(
                              widget.dateOrgName,
                              style: tileTextNumberStyle.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            //date and icon
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.organizationCategory,
                              style:
                                  tileTextTitleStyle.copyWith(fontSize: 16.sp),
                            ),
                            SizedBox(
                              width: 160.w,
                            ),
                            Text(
                              widget.dateOrgCategory,
                              style: tileTextNumberStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Divider(
                  height: 12,
                  thickness: 1,
                  color: kLightGreyColor,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.subject,
                        style: tileTextTitleStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: kMediumGreyColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
