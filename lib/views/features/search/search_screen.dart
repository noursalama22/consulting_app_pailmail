import 'package:consulting_app_pailmail/models/mails/mail.dart';
import 'package:consulting_app_pailmail/repositories/search_repository.dart';
import 'package:consulting_app_pailmail/views/features/inbox_mails/inbox_screen.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/routers/router.dart';
import '../../../core/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  List<Mail>? mails;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchtextEditingController;
  String statusId = '';
  bool isChangedIconColor = false;
  bool isChangedBarColor = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _searchtextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchtextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Search",
          style: tileTextTitleStyle.copyWith(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: kLightBlueColor,
        ),
        leading: IconButton(
          onPressed: () {
            NavigationRoutes().pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          top: 12.h,
        ),
        child: Column(
          children: [
            /// Search Bar
            /// //TODO : Handle button splash raduis
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    //TODO:ADD fn
                    onChanged: (value) {
                      setState(() {
                        isChangedIconColor = true;
                        isChangedBarColor = false;
                        isLoading = false;
                      });
                      // //TODO add Debouncer
                      // widget.mails = [];
                      // var response = await SearchRepository().search(
                      //     text: value,
                      //     status_id: statusId == -1 ? null : statusId);
                      // print(response);
                      // setState(() {
                      //   widget.mails = response.mails;
                      // });
                    },
                    onSubmitted: (value) async {
                      setState(() {
                        isChangedBarColor = true;
                      });
                      //TODO add Debouncer

                      widget.mails = [];
                      isLoading = true;
                      SearchRepository()
                          .search(
                              text: value,
                              status_id: statusId == '0' ? '' : statusId)
                          .then((value) {
                        isLoading = false;
                        var response = value;
                        setState(() {
                          widget.mails = response.mails;
                        });
                      });
                    },
                    controller: _searchtextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Color(0xff272727),
                    ),
                    cursorColor: kDarkGreyColor,
                    decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor:
                          isChangedBarColor ? kWhiteColor : Color(0xFFEAEAF5),
                      // fillColor: Color(0xFFE6E6E6),

                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 14, horizontal: 0),
                      focusedBorder: buildOutlineInputBorderTextField(),
                      enabledBorder: buildOutlineInputBorderTextField(),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFFAFAFAF),
                        size: 24,
                      ),
                      hintText: "search",
                      hintStyle: buildAppBarTextStyle(
                          fontSizeController: 16,
                          color: kMediumGreyColor,
                          letterSpacing: 0.15),
                      //Add  Animated Icon
                      suffixIcon: IconButton(
                        splashRadius: 10,
                        // splashColor: kLightGreyColor,
                        onPressed: () {
                          isChangedIconColor = false;
                          _searchtextEditingController.clear();
                          widget.mails = null;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: isChangedIconColor
                              ? kLightBlueColor
                              : Color(0xFFAFAFAF),
                        ),
                      ),
                    ),
                  ),
                  // child: CustomTextField(
                  //   withoutPrefix: false,
                  //   icon: Icons.search,
                  //   iconColor: const Color(0xFFAFAFAF),
                  //   hintText: 'search',
                  //   customFontSize: 14,
                  //   controller: _searchtextEditingController,
                  // ),
                ),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.search_filters_screen)
                        .then((value) {
                      print('status id ------------$value');
                      if (value != -1) {
                        print('filter @@@@@@@@@');
                        statusId = (value.toString());
                      }
                    });
                    // NavigationRoutes()
                    //     .jump(context, Routes.search_filters_screen);
                  },
                  child: Image.asset(
                    'assets/images/filter.png',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            isLoading
                ? Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: ListTile(
                            title: Text('Item number  as title'),
                            subtitle: Text('Subtitle here'),
                            trailing: Icon(
                              Icons.ac_unit,
                              size: 32,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : widget.mails != null
                    ? widget.mails!.length != 0
                        ? Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                var data = widget.mails;
                                return CustomMailContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return InboxScreen(
                                          isDetails: true,
                                          mail: data[index],
                                        );
                                      },
                                    ));
                                  },
                                  organizationName:
                                      data![index].sender!.name ?? "",
                                  color: Color(int.parse(
                                      data[index].status!.color.toString())),
                                  date: data[index].archiveDate ?? "",
                                  description: data[index].description ?? "",
                                  images: const [],
                                  tags: data[index].tags ?? [],
                                  subject: data[index].subject ?? "",
                                  endMargin: 8,
                                );
                              },
                              itemCount: widget.mails!.length,
                            ),
                          )
                        : const Text(
                            "No mails",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                    : SizedBox(),
            // SizedBox(
            //   width: 10,
            // ),
            //
            // ///Completed mails
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "25 Completed",
            //       style: GoogleFonts.poppins(
            //           fontSize: 14.sp, color: kDarkGreyColor),
            //     ),
            //     TextButton(
            //       onPressed: () {},
            //       child: Text(
            //         "Show",
            //         style: tagsTextStyle,
            //       ),
            //     ),
            //   ],
            // ),
            //
            // Divider(
            //   color: Color(0xFFAFAFAF),
            //   thickness: 0.5,
            // ),
            //
            // ///Result of Search
            // Expanded(
            //   child: ListView.builder(
            //     //    physics: NeverScrollableScrollPhysics(),
            //     itemCount: 3,
            //     padding: EdgeInsetsDirectional.zero,
            //     //        physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return CustomExpansionTile(
            //         isExpanded: false,
            //         mailNumber: "3 Founds",
            //         isIndexWidet: true,
            //         widgetOfTile: Text(
            //           "Official Organization",
            //           style: GoogleFonts.poppins(
            //               fontSize: 18.sp, color: kDarkGreyColor),
            //         ),
            //         children: [
            //           ListView.builder(
            //             itemBuilder: (context, index) {
            //               return CustomMailContainer(
            //                 onTap: () {},
            //                 organizationName: 'Organization Name',
            //                 color: kYellowColor,
            //                 date: "Today, 11:00 AM",
            //                 description:
            //                     "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
            //                 images: [],
            //                 tags: [
            //                   // "urgent",
            //                   // "new",
            //                   // "water",
            //                 ],
            //                 subject: "Here we add the subject",
            //                 endMargin: 16,
            //               );
            //             },
            //             shrinkWrap: true,
            //             physics: const NeverScrollableScrollPhysics(),
            //             itemCount: 3,
            //             // physics: NeverScrollableScrollPhysics(),
            //             //      physics: NeverScrollableScrollPhysics(),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
