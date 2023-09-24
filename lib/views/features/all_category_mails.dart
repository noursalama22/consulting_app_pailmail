import 'package:consulting_app_pailmail/models/mails/mail.dart';
import 'package:consulting_app_pailmail/views/features/inbox_mails/inbox_screen.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:flutter/material.dart';

class AllCategoryMails extends StatefulWidget {
  const AllCategoryMails(
      {Key? key, required this.mailsList, this.isCateogry = true})
      : super(key: key);
  // final int index;
  final dynamic mailsList;
  final bool isCateogry;
  @override
  State<AllCategoryMails> createState() => _AllCategoryMailsState();
}

class _AllCategoryMailsState extends State<AllCategoryMails> {
  Color hexToColor(String hexString, {String alphaChannel = 'ff'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'All ${widget.isCateogry ? widget.mailsList[0].sender.category.name : widget.mailsList[0].status.name} Mails',
          // 'All ${widget.mailsList[0].sender.category.name}  Mails',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return CustomMailContainer(
              onTap: () {
                navigateToMailDetails(widget.mailsList[index]);
              },
              organizationName: widget.mailsList[index].sender!.name ?? "",
              color: hexToColor(widget.mailsList[index].status!.color ?? ''),
              date: widget.mailsList[index].archiveDate ?? "",
              description: widget.mailsList[index].description ?? "",
              images: [],
              tags: widget.mailsList[index].tags ?? [],
              subject: widget.mailsList[index].subject ?? "",
              endMargin: 8,
            );
          },
          itemCount: widget.mailsList.length,
          shrinkWrap: true,
        ),
      ),
    ));
  }

/*
   Consumer<CategoriesProvider>(builder: (BuildContext context,
                CategoriesProvider value, Widget? child) {
              var data = value.mailsCategory[widget.index].data;

              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return CustomMailContainer(
                      onTap: () {

                      },
                      organizationName: data![index].sender!.name ?? "",

                      color: kYellowColor,
                      date: data[index].archiveDate ?? "",
                      description: data[index].description ?? "",
                      images: [],
                      tags: data[index].tags ?? [],
                      subject: data[index].subject ?? "",
                      endMargin: 8,
                    );
                  },
                  itemCount: data!.length,
                  shrinkWrap: true,
                ),
              );
            }),
 */
  navigateToMailDetails(Mail mail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return InboxScreen(
            isDetails: true,
            mail: mail,
            IsSender: false,
          );
        },
      ),
    );
  }
}
