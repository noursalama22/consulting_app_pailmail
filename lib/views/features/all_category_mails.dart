import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/providers/categories_provider.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoryMails extends StatefulWidget {
  const AllCategoryMails({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<AllCategoryMails> createState() => _AllCategoryMailsState();
}

class _AllCategoryMailsState extends State<AllCategoryMails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Mails',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(children: [
            // const CustomAppBar(
            //   widgetName: "All Mails",
            //   bottomPadding: 25,
            // ),
            Consumer<CategoriesProvider>(builder: (BuildContext context,
                CategoriesProvider value, Widget? child) {
              var data = value.mailsCategory[widget.index].data;

              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return CustomMailContainer(
                      onTap: () {},
                      organizationName: data![index].sender!.name ?? "",
                      color: kYellowColor,
                      date: data![index].archiveDate ?? "",
                      description: data![index].description ?? "",
                      images: [],
                      tags: data![index].tags ?? [],
                      subject: data![index].subject ?? "",
                      endMargin: 8,
                    );
                  },
                  itemCount: data!.length,
                  shrinkWrap: true,
                ),
              );
            }),
          ]),
        ),
      ),
    );
  }

  navigateToAllMail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AllCategoryMails(
            index: index,
          );
        },
      ),
    );
  }
}
