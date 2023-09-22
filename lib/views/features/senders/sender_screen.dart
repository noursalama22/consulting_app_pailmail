
import 'package:consulting_app_pailmail/models/senders/sender_response_model.dart';
import 'package:consulting_app_pailmail/models/senders/senders_1.dart';
import 'package:consulting_app_pailmail/providers/categories_provider.dart';

import 'package:consulting_app_pailmail/repositories/sender_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants.dart';
import '../../../models/senders/sender.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';

class SenderScreen extends StatefulWidget {
  const SenderScreen({Key? key}) : super(key: key);

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {

  SenderRepository sn = SenderRepository();

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<Sender?>? datas;
    // String? name;

    return Scaffold(
      backgroundColor: kBackgroundColor,

      ///App Bar
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              top: 20.0.h, start: 20.w, bottom: 62.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                onTap: () {
                  Navigator.pop(context);
                },
                widgetName: 'Sender',
                isEdit: true,
                endPadding: 27.w,
                bottomPadding: 15.h,
              ),

              ///Search Bar
              Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: const CustomSearchBar(),
              ),

              ///Text of Search
              ///
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
      ),
    );
  }

  Consumer<CategoriesProvider> buildListViewOfSendersContainers() {
    return Consumer<CategoriesProvider>(
      builder: (context, categoriesProvider, child) {
        if (categoriesProvider.allCategories.status == ApiStatus.COMPLETED) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index1) {
                final category = categoriesProvider.allCategories.data![index1];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Company Name
                    ///هيتغير لما يجي من ال api
                    Padding(
                      padding: EdgeInsets.only(top: 23.0, bottom: 4.h),
                      child: Text(
                        category.name.toString(),
                        style: buildAppBarTextStyle(
                            fontSizeController: 12,
                            color: const Color(0xffafafaf)),
                      ),
                    ),

                    ///هيتغير اسم السيندر لما يجي من ال api
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
                                print(index1);
                                Provider.of<CategoriesProvider>(context,
                                        listen: false)
                                    .getSender(
                                        selectedIndex: indexSender,
                                        categoryIndex: index1);
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
                                      Text(
                                        category.senders![indexSender].mobile
                                            .toString(),
                                        style: buildAppBarTextStyle(
                                            fontSizeController: 14,
                                            color: kBlackColor),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: categoriesProvider
                            .allCategories.data![index1].senders!.length),
                  ],
                );
              },
              itemCount: 4);
        }
        if (categoriesProvider.allCategories.status == ApiStatus.LOADING) {
          return const CircularProgressIndicator();
        }
        return Text(categoriesProvider.allCategories.message.toString());
      },
    );
  }
}
