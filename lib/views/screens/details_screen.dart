import 'package:consulting_app_pailmail/views/widgets/custom_app_bar.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_app_bar_with_icons.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_container_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helpers/constants.dart';
import '../widgets/custom_container.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: 20.0.w, end: 20.0.w, bottom: 16.h),
          child: Column(
            children: [
              CustomAppBarWithIcon(
                widgetName: "Details",
                left_icon: Icons.arrow_back_ios_new,
                right_icon: Icons.menu,
              ),

              //show  details about mail
              CustomContainerDetails(
                  organizationName: "Emmett Balistreri",
                  organizationCategory: "Foreign",
                  dateOrgName: "4-JAN_1990",
                  dateOrgCategory: "A-Nov-5",
                  subject: "Dr.",
                  onPress: () {}),

              //Tags it will open bottom Sheet
              buildListTile(
                icon: Icons.tag_rounded,
                widget: Text(
                  "Tags",
                  style: buildAppBarTextStyle(
                      color: const Color(0xff272727),
                      letterSpacing: 0.15,
                      fontSizeController: 16.sp),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),

              /// Status it will view Status screen
              buildListTile(
                icon: Icons.add_business_outlined,
                widget: Row(
                  children: [
                    CustomContainer(
                      isInBox: true,
                      backgroundColor: kYellowColor,
                      childContainer: Text(
                        "Pending",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 12.h,
              ),
              //show description
              CustomContainer(
                  childContainer: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Decision",
                      style: buildAppBarTextStyle(
                          color: kBlackColor, letterSpacing: 0.15),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "we can do more to this like And we can do more to this like ",
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomContainer buildListTile(
      {required IconData icon, required Widget widget}) {
    return CustomContainer(
      childContainer: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 18.0),
          child: Icon(
            icon,
            size: 20,
            color: kDarkGreyColor,
          ),
        ),
        title: widget,
        trailing: const Padding(
          padding: EdgeInsetsDirectional.only(end: 17.0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: kMediumGreyColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
