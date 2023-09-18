import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/providers/status_provider.dart';
import 'package:consulting_app_pailmail/views/features/search/search_filters_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../models/statuses/status.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_list_row_state.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  static List<Color> colors = [
    kRedColor,
    kYellowColor,
    kLightBlueColor,
    kGreenColor
  ];
  @override
  void initState() {
    // TODO: implement initState
    StatusProvider statusProvider = Provider.of<StatusProvider>(context, listen: false);

    fetch(statusProvider);
    super.initState();
  }

  static List<String> statusList = [];
  void fetch(StatusProvider value) {
    // Check if allStatus.data is not null
    if (value.allStatus.data != null) {
      // Iterate through the elements in allStatus.data
      for (int i = 0; i < value.allStatus.data!.length; i++) {
        var element = value.allStatus.data![i];

        // Check if the element is not null
        if (element != null) {
          statusList.add(element.name.toString());
          print("$element element");
        }
      }
    }
  }

  // static List<String> status = ["Inbox", "Pending", "in Progress", "Completed"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding:
            EdgeInsets.only(top: 20.0.h, left: 20.w, right: 20.w, bottom: 62.h),
        child: Column(children: [
          ///app Bar
          const CustomAppBar(
            widgetName: 'Status',
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
                Consumer<StatusProvider>(
                  builder: (context, statusProvider, child) {
                    if (statusProvider.allStatus.status == ApiStatus.LOADING) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (statusProvider.allStatus.status ==
                        ApiStatus.COMPLETED) {
                      print(statusList);
                      return CustomListRowState<Status>(
                        list: statusList,
                        isStatus: true,
                        color: colors,
                      );
                    } else {
                      return Text(statusProvider.allStatus.message.toString());
                    }
                  },
                ),

                ///view and select status
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
