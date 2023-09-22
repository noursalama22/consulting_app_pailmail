import 'package:consulting_app_pailmail/models/senders/sender_response_model.dart';
import 'package:consulting_app_pailmail/models/senders/senders_1.dart';
import 'package:consulting_app_pailmail/providers/categories_provider.dart';
import 'package:consulting_app_pailmail/providers/sender_provider.dart';
import 'package:consulting_app_pailmail/repositories/sender_repository.dart';
import 'package:consulting_app_pailmail/views/features/inbox_mails/inbox_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/api_helpers/api_response.dart';
import '../../../../../core/helpers/routers/router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_search_bar.dart';

class Senders extends StatefulWidget {
  const Senders({Key? key}) : super(key: key);

  @override
  State<Senders> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<Senders> {
  // int selindex;
  @override
  SenderRepository sn = SenderRepository();

  void initState() {
    // TODO: implement initState    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<Sender?>? datas;    // String? name;
    return Scaffold(
        backgroundColor: kBackgroundColor,

        ///App Bar
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                top: 20.0.h, start: 20.w, bottom: 62.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomAppBar(
                onTap: () {
                  Navigator.pop(context);
                },
                widgetName: 'Sender',
                endPadding: 27.w,
                bottomPadding: 15.h,
              ),

              ///Search Bar
              Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: const CustomSearchBar(),
              ),

              ///Text of Search              ///

              buildListViewOfSendersContainers()
            ]),
          ),
        ));
  }

  Consumer<CategoriesProvider> buildListViewOfSendersContainers() {
    return Consumer<CategoriesProvider>(
      builder: (context, categoryProvider, child) {
        if (categoryProvider.allCategories.status == ApiStatus.COMPLETED) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index1) {
                final category = categoryProvider.allCategories.data![index1];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Company Name
                    Padding(
                      padding: EdgeInsets.only(top: 23.0, bottom: 4.h),
                      child: Text(
                        category.name.toString(),
                        style: buildAppBarTextStyle(
                            fontSizeController: 12,
                            color: const Color(0xffafafaf)),
                      ),
                    ),

                    ///sender convert it to future builder
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexSender) {
                          return Container(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 20.h),
                            decoration: buildBoxDecoration(),
                            child: InkWell(
                              onTap: () {
                                print("sssss $indexSender");
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return InboxScreen(isDetails: true);
                                  },
                                ));
                                // print(index1);
                                // Provider.of<CategoriesProvider>(context,
                                //         listen: false)
                                //     .getSender(
                                //         selectedIndex: indexSender,
                                //         categoryIndex: index1);
                                // sn.deleteSender(category
                                //     .senders![indexSender].id
                                //     .toString());
                                // Provider.of<CategoriesProvider>(context,
                                //         listen: false)
                                //     .allCategories;
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale:
                                        1.5, // Adjust the scale factor as needed
                                    child: Container(
                                      margin:
                                          EdgeInsetsDirectional.only(end: 8.h),
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category.senders![indexSender].name
                                            .toString(),
                                        style: buildAppBarTextStyle(
                                            fontSizeController: 14,
                                            color: kBlackColor),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: categoryProvider
                            .allCategories.data![index1].senders!.length),
                  ],
                );
              },
              itemCount: categoryProvider.allCategories.data!.length);
        }
        if (categoryProvider.allCategories.status == ApiStatus.LOADING) {
          return const CircularProgressIndicator();
        }
        return Text(categoryProvider.allCategories.message.toString());
      },
    );
  }
}

// import 'package:consulting_app_pailmail/providers/categories_provider.dart';
// import 'package:consulting_app_pailmail/providers/sender_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../core/helpers/api_helpers/api_response.dart';
// import '../../../../../core/utils/constants.dart';
// import '../../../../../models/categories/category_response_model.dart';
// import '../../../../../models/senders/senders_1.dart';
// import '../../../../../repositories/sender_repository.dart';
// import '../../../../widgets/custom_app_bar.dart';
// import '../../../../widgets/custom_search_bar.dart';
//
// class Senders extends StatefulWidget {
//   const Senders({super.key});
//
//   @override
//   State<Senders> createState() => _SendersState();
// }
//
// class _SendersState extends State<Senders> {
//   SenderRepository? sn;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: kBackgroundColor,
//         body: Padding(
//             padding: EdgeInsetsDirectional.only(
//                 top: 20.0.h, start: 20.w, bottom: 62.h),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               CustomAppBar(
//                 widgetName: 'Sender',
//                 endPadding: 27.w,
//                 bottomPadding: 15.h,
//               ),
//
//               ///Search Bar
//               Padding(
//                 padding: EdgeInsetsDirectional.only(end: 12.w),
//                 child: const CustomSearchBar(),
//               ),
//
//               SingleChildScrollView(
//                 physics: AlwaysScrollableScrollPhysics(),
//                 child: Consumer<CategoriesProvider>(
//                     builder: (_, categoryProvider, __) {
//                   if (categoryProvider.allCategories.status ==
//                       ApiStatus.LOADING) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (categoryProvider.allCategories.status ==
//                       ApiStatus.ERROR) {
//                     return Center(
//                       child: Text('${categoryProvider.allCategories.message}'),
//                     );
//                   }
//                   //CategoryElement send = categoryProvider.allCategories.data![index];
//                   return ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       CategoryElement categoryName =
//                           categoryProvider.allCategories.data![index];
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ///Company Name
//                           ///هيتغير لما يجي من ال api
//                           Padding(
//                             padding: EdgeInsets.only(top: 23.0, bottom: 4.h),
//                             child: Text(
//                               categoryName.name.toString(),
//                               style: buildAppBarTextStyle(
//                                   fontSizeController: 12,
//                                   color: const Color(0xffafafaf)),
//                             ),
//                           ),
//
//                           ///هيتغير اسم السيندر لما يجي من ال api
//                           ///sender convert it to future builder
//                           ListView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               padding: EdgeInsets.zero,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 // CategoryElement categorySender=categoryProvider.allCategories.data![index];
//                                 return Container(
//                                   padding: EdgeInsetsDirectional.symmetric(
//                                       vertical: 20.h),
//                                   decoration: buildBoxDecoration(),
//                                   child: InkWell(
//                                     onTap: () {
//                                       String id = categoryName
//                                           .senders![index].id
//                                           .toString();
//                                       sn = SenderRepository().deleteSender(id)
//                                           as SenderRepository?;
//                                     },
//                                     child: Row(
//                                       children: [
//                                         Transform.scale(
//                                           scale: 1.5,
//                                           // Adjust the scale factor as needed
//                                           child: Container(
//                                             margin: EdgeInsetsDirectional.only(
//                                                 end: 8.h),
//                                             decoration: const BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: kDarkGreyColor,
//                                             ),
//                                             child: const Icon(
//                                               Icons.person,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                         Text(
//                                           categoryName.senders![index].name
//                                               .toString(),
//                                           style: buildAppBarTextStyle(
//                                               fontSizeController: 14,
//                                               color: kBlackColor),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               //categoryName.senders!.length
//                               itemCount: 5),
//                         ],
//                       );
//                     },
//                     itemCount: categoryProvider.allCategories.data!.length,
//                   );
//                 }),
//               ),
//             ])));
//   }
// }
