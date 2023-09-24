import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/models/senders/sender_response_model.dart';
import 'package:consulting_app_pailmail/models/senders/senders_1.dart';
import 'package:consulting_app_pailmail/providers/categories_provider.dart';

import 'package:consulting_app_pailmail/repositories/sender_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../../models/senders/sender.dart';
import '../../../repositories/search_repository.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';

class SenderScreen extends StatefulWidget {
  const SenderScreen({Key? key}) : super(key: key);

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  SenderRepository sn = SenderRepository();
  bool isCheck = false;
  bool iSearch = false;
  late int index = -1;
  int catIndex = -1;
  late TextEditingController searchController;
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  if (index != -1) {
                    isCheck = true;
                  }
                  Navigator.pop(context, isCheck);
                },
                widgetName: 'Sender',
                isEdit: true,
                endPadding: 27.w,
                bottomPadding: 15.h,
              ),

              ///Search Bar
              Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: CustomSearchBar(
                  isSenderPage: true,
                  searchController: searchController,
                  onTap: (input) async {
                    setState(() {});
                  },
                ),
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
                var sender =
                    categoriesProvider.allCategories.data![index1].senders;
                if (searchController.text.isNotEmpty) {
                  sender = sender
                      ?.where((senderInfo) =>
                          senderInfo.name!.contains(searchController.text))
                      .toList();
                }
                return sender!.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
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
                                  padding: EdgeInsetsDirectional.symmetric(
                                      vertical: 20.h),
                                  decoration: buildBoxDecoration(),
                                  child: InkWell(
                                    onTap: () {
                                      print("sssss $indexSender");
                                      print(index1);
                                      index = indexSender;
                                      catIndex = index1;

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
                                            margin: EdgeInsetsDirectional.only(
                                                end: 8.h),
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
                                              sender![indexSender]
                                                  .name
                                                  .toString(),
                                              style: buildAppBarTextStyle(
                                                  fontSizeController: 14,
                                                  color: kBlackColor),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              sender![indexSender]
                                                  .mobile
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
                              itemCount: sender!.length),
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
