import 'package:consulting_app_pailmail/views/widgets/custom_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/helpers/constants.dart';
import '../widgets/custom_app_bar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> categories = [
    "Official organization",
    "NGOs",
    "UnBorder",
    "Others"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsetsDirectional.only(
            top: 20.0.h, start: 20.w, end: 20.w, bottom: 62.h),
        child: Column(children: [
          ///app Bar
          const CustomAppBar(
            widgetName: 'Category',
          ),

          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  /// select category
                  _CustomStatusRowState(
                    statusText: "Official organization",
                    index: 0,
                  ),
                  _CustomStatusRowState(
                    statusText: "NGOs",
                    index: 1,
                  ),
                  _CustomStatusRowState(
                    statusText: "UnBorder",
                    index: 2,
                  ),
                  _CustomStatusRowState(
                    statusText: "Others",
                    index: 3,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  int isSelected = 0;

  int count = 0;

  Widget _CustomStatusRowState(
      {required String statusText, required int index}) {
    return CustomContainer(
        childContainer: Padding(
      padding: index != 2
          ? EdgeInsetsDirectional.only(start: 18.h)
          : EdgeInsets.zero,
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() {
              isSelected = index;
            }),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: index == 2
                        ? EdgeInsetsDirectional.only(start: 18.0)
                        : EdgeInsets.zero,
                    child: Text(
                      statusText,
                      style: buildAppBarTextStyle(
                          color: kBlackColor,
                          fontSizeController: 16,
                          letterSpacing: 0.15),
                    ),
                  ),
                  const Spacer(),
                  isSelected == index
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
          index != 3 && index != 2
              ? Divider(
                  indent: 8.0.w,
                  thickness: 1.2,
                )
              : const SizedBox.shrink(),
          index == 2
              ? const Divider(
                  thickness: 1.7,
                )
              : const SizedBox.shrink()
        ],
      ),
    ));
  }
}
