import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_expansion_tile.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'index_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchtextEditingController;

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
            Navigator.pop(context);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    //TODO:ADD fn
                    onChanged: (value) {},
                    onSubmitted: (v) {},
                    controller: _searchtextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Color(0xff272727)),
                    cursorColor: kDarkGreyColor,
                    decoration: InputDecoration(
                      filled: true,
                      //<-- SEE HERE
                      fillColor: Color(0xFFEAEAF5),
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
                          // color: Color(0xFF272727),
                          //TODO : Check below color !!!!!!
                          // color: const Color(0xffafafaf),
                          letterSpacing: 0.15),
                      //Add  Animated Icon
                      suffixIcon: IconButton(
                        splashRadius: 10,
                        // splashColor: kLightGreyColor,
                        onPressed: () {
                          _searchtextEditingController.clear();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Color(0xFFAFAFAF),
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
                  child: Image.asset(
                    'assets/images/filter.png',
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),

            ///Completed mails
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "25 Completed",
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp, color: kDarkGreyColor),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Show",
                    style: tagsTextStyle,
                  ),
                ),
              ],
            ),

            Divider(
              color: Color(0xFFAFAFAF),
              thickness: 0.5,
            ),

            ///Result of Search
            Expanded(
              child: ListView.builder(
                //    physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                padding: EdgeInsetsDirectional.zero,
                //        physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomExpansionTile(
                    isExpanded: false,
                    mailNumber: "3 Founds",
                    isIndexWidet: true,
                    widgetOfTile: Text(
                      "Official Organization",
                      style: GoogleFonts.poppins(
                          fontSize: 18.sp, color: kDarkGreyColor),
                    ),
                    children: [
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return CustomMailContainer(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return IndexScreen(isDetails: true);
                                },
                              ));
                            },
                            organizationName: 'Organization Name',
                            color: kYellowColor,
                            date: "Today, 11:00 AM",
                            description:
                                "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
                            images: [],
                            tags: [
                              "urgent",
                              "new",
                              "water",
                            ],
                            subject: "Here we add the subject",
                            endMargin: 16,
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        // physics: NeverScrollableScrollPhysics(),
                        //      physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
// }  Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// "Official Organization",
// style: GoogleFonts.poppins(
// fontSize: 18.sp, color: kDarkGreyColor),
// ),
// Text(
// "2 Found",
// //TODO : Style
// style: buildAppBarTextStyle(
// color: kMediumGreyColor,
// fontSizeController: 14,
// letterSpacing: 0.15),
// ),
// ],
// ),
// SizedBox(
// height: 10,
// ),
// // CustomExpansionTile(
// //     widgetOfTile: Text(
// //       "Official Organization",
// //       style: GoogleFonts.poppins(
// //           fontSize: 18.sp, color: kDarkGreyColor),
// //     ),
// //     isExpanded: false,
// //     isIndexWidet: true,
// //     mailNumber: "2 Found",
// //     children: []
// //     //   ListView.builder(
// //     //     itemBuilder: (context, index) {
// //     //       return CustomMailContainer(
// //     //         organizationName: 'Organization Name',
// //     //         color: kYellowColor,
// //     //         date: "Today, 11:00 AM",
// //     //         description:
// //     //             "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
// //     //         images: [],
// //     //         tags: [
// //     //           "urgent",
// //     //           "new",
// //     //           "water",
// //     //         ],
// //     //         subject: "Here we add the subject",
// //     //         endMargin: 16,
// //     //       );
// //     //     },
// //     //     shrinkWrap: true,
// //     //     // physics: NeverScrollableScrollPhysics(),
// //     //     //      physics: NeverScrollableScrollPhysics(),
// //     //   ),
// //     //       ],
// //     // children: [
// //     //   ListView.builder(
// //     //     itemBuilder: (context, index) {
// //     //       return CustomMailContainer(
// //     //         organizationName: 'Organization Name',
// //     //         color: kYellowColor,
// //     //         date: "Today, 11:00 AM",
// //     //         description:
// //     //             "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
// //     //         images: [],
// //     //         tags: [
// //     //           "urgent",
// //     //           "new",
// //     //           "water",
// //     //         ],
// //     //         subject: "Here we add the subject",
// //     //         endMargin: 16,
// //     //       );
// //     //     },
// //     //     shrinkWrap: true,
// //     //     // physics: NeverScrollableScrollPhysics(),
// //     //     //      physics: NeverScrollableScrollPhysics(),
// //     //   ),
// //     // ],
// //     ),
// //  Row(
// //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   children: [
// //     Text(
// //       "25 Completed",
// //       style: GoogleFonts.poppins(
// //           fontSize: 14.sp, color: kDarkGreyColor),
// //     ),
// //     TextButton(
// //       onPressed: () {},
// //       child: Text(
// //         "Show",
// //         style: tagsTextStyle,
// //       ),
// //     ),
// //   ],
// // ),
// ListView.builder(
// itemBuilder: (context, index) {
// return CustomMailContainer(
// organizationName: 'Organization Name',
// color: kYellowColor,
// date: "Today, 11:00 AM",
// description:
// "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
// images: [],
// tags: [
// "urgent",
// "new",
// "water",
// ],
// subject: "Here we add the subject",
// endMargin: 16,
// );
// },
// shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
// itemCount: 2,
// // physics: NeverScrollableScrollPhysics(),
// //      physics: NeverScrollableScrollPhysics(),
// ),
// // Row(
// //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   children: [
// //     Text(
// //       "Official Organization",
// //       style: GoogleFonts.poppins(
// //           fontSize: 18.sp, color: kDarkGreyColor),
// //     ),
// //     Text(
// //       "2 Found",
// //       style: GoogleFonts.poppins(
// //           fontSize: 14.sp, color: kDarkGreyColor),
// //     ),
// //   ],
// // ),
// // SizedBox(
// //   height: 12,
// // ),
// //
// ],
// );
//return Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Official Organization",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 18.sp, color: kDarkGreyColor),
//                           ),
//                           Text(
//                             "2 Found",
//                             //TODO : Style
//                             style: buildAppBarTextStyle(
//                                 color: kMediumGreyColor,
//                                 fontSizeController: 14,
//                                 letterSpacing: 0.15),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       // CustomExpansionTile(
//                       //     widgetOfTile: Text(
//                       //       "Official Organization",
//                       //       style: GoogleFonts.poppins(
//                       //           fontSize: 18.sp, color: kDarkGreyColor),
//                       //     ),
//                       //     isExpanded: false,
//                       //     isIndexWidet: true,
//                       //     mailNumber: "2 Found",
//                       //     children: []
//                       //     //   ListView.builder(
//                       //     //     itemBuilder: (context, index) {
//                       //     //       return CustomMailContainer(
//                       //     //         organizationName: 'Organization Name',
//                       //     //         color: kYellowColor,
//                       //     //         date: "Today, 11:00 AM",
//                       //     //         description:
//                       //     //             "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
//                       //     //         images: [],
//                       //     //         tags: [
//                       //     //           "urgent",
//                       //     //           "new",
//                       //     //           "water",
//                       //     //         ],
//                       //     //         subject: "Here we add the subject",
//                       //     //         endMargin: 16,
//                       //     //       );
//                       //     //     },
//                       //     //     shrinkWrap: true,
//                       //     //     // physics: NeverScrollableScrollPhysics(),
//                       //     //     //      physics: NeverScrollableScrollPhysics(),
//                       //     //   ),
//                       //     //       ],
//                       //     // children: [
//                       //     //   ListView.builder(
//                       //     //     itemBuilder: (context, index) {
//                       //     //       return CustomMailContainer(
//                       //     //         organizationName: 'Organization Name',
//                       //     //         color: kYellowColor,
//                       //     //         date: "Today, 11:00 AM",
//                       //     //         description:
//                       //     //             "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
//                       //     //         images: [],
//                       //     //         tags: [
//                       //     //           "urgent",
//                       //     //           "new",
//                       //     //           "water",
//                       //     //         ],
//                       //     //         subject: "Here we add the subject",
//                       //     //         endMargin: 16,
//                       //     //       );
//                       //     //     },
//                       //     //     shrinkWrap: true,
//                       //     //     // physics: NeverScrollableScrollPhysics(),
//                       //     //     //      physics: NeverScrollableScrollPhysics(),
//                       //     //   ),
//                       //     // ],
//                       //     ),
//                       //  Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //   children: [
//                       //     Text(
//                       //       "25 Completed",
//                       //       style: GoogleFonts.poppins(
//                       //           fontSize: 14.sp, color: kDarkGreyColor),
//                       //     ),
//                       //     TextButton(
//                       //       onPressed: () {},
//                       //       child: Text(
//                       //         "Show",
//                       //         style: tagsTextStyle,
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       ListView.builder(
//                         itemBuilder: (context, index) {
//                           return CustomMailContainer(
//                             organizationName: 'Organization Name',
//                             color: kYellowColor,
//                             date: "Today, 11:00 AM",
//                             description:
//                                 "And here excerpt of the mail, can added to this location. And we can do more to this like And we can do more to this like ",
//                             images: [],
//                             tags: [
//                               "urgent",
//                               "new",
//                               "water",
//                             ],
//                             subject: "Here we add the subject",
//                             endMargin: 16,
//                           );
//                         },
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: 2,
//                         // physics: NeverScrollableScrollPhysics(),
//                         //      physics: NeverScrollableScrollPhysics(),
//                       ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //   children: [
//                       //     Text(
//                       //       "Official Organization",
//                       //       style: GoogleFonts.poppins(
//                       //           fontSize: 18.sp, color: kDarkGreyColor),
//                       //     ),
//                       //     Text(
//                       //       "2 Found",
//                       //       style: GoogleFonts.poppins(
//                       //           fontSize: 14.sp, color: kDarkGreyColor),
//                       //     ),
//                       //   ],
//                       // ),
//                       // SizedBox(
//                       //   height: 12,
//                       // ),
//                       //
//                     ],
//                   );
