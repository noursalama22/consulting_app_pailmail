import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helpers/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_bar.dart';

class SenderScreen extends StatelessWidget {
  const SenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      ///App Bar
      body: Padding(
        padding:
            EdgeInsetsDirectional.only(top: 20.0.h, start: 20.w, bottom: 62.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              widgetName: 'Sender',
              endPadding: 27.w,
              bottomPadding: 15.h,
            ),

            ///Search Bar
            Padding(
              padding: EdgeInsetsDirectional.only(end: 12.w),
              child: const CustomSearchBar(),
            ),

            ///Text of Search
            Container(
                width: double.infinity,
                margin: EdgeInsetsDirectional.only(top: 24.h),
                padding: EdgeInsetsDirectional.symmetric(
                  vertical: 20.h,
                ),
                decoration: buildBoxDecoration(),
                child: Text("'Sport'",
                    style: buildAppBarTextStyle(
                        color: kBlackColor, fontSizeController: 14.sp))),
            buildListViewOfSendersContainers()
          ],
        ),
      ),
    );
  }

  ListView buildListViewOfSendersContainers() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Company Name
            ///هيتغير لما يجي من ال api
            Padding(
              padding: EdgeInsets.only(top: 23.0, bottom: 4.h),
              child: Text(
                "Official ORG",
                style: buildAppBarTextStyle(
                    fontSizeController: 12, color: const Color(0xffafafaf)),
              ),
            ),

            ///هيتغير اسم السيندر لما يجي من ال api
            ///sender convert it to future builder
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 20.h),
                    decoration: buildBoxDecoration(),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.5, // Adjust the scale factor as needed
                          child: Container(
                            margin: EdgeInsetsDirectional.only(end: 8.h),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: kDarkGreyColor,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Sender 1",
                          style: buildAppBarTextStyle(
                              fontSizeController: 14, color: kBlackColor),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 2),
          ],
        );
      },
      itemCount: 2,
    );
  }
}
