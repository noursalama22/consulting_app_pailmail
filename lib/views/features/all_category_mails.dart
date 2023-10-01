import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/models/mails/mail.dart';
import 'package:consulting_app_pailmail/views/features/inbox_mails/inbox_screen.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:easy_localization/easy_localization.dart';
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

  List<List<Mail>> mailsOfCat = [[], [], [], []];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mailsList.length != 0) {
      print("llllllllllllllllll${widget.mailsList.length}");
      for (int i = 0; i < widget.mailsList!.length; i++) {
        print("llllllllllllllllll");

        mailsOfCat[indexOfCat(widget.mailsList[i])].add(widget.mailsList[i]);
      }
    }
  }

  int indexOfCat(Mail mail) {
    switch (mail.sender!.categoryId) {
      case "1":
        return 3;
      case "2":
        return 0;
      case "3":
        return 1;
      case "4":
        return 2;
      default:
        return 0;
    }
  }

  String fetchOrgName(int index) {
    switch (index) {
      case 0:
        return "officialOrganizations";
      case 1:
        return "ngos";
      case 2:
        return "foreign";
      case 3:
        return "other";
      default:
        return "";
    }
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
          itemBuilder: (context, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !mailsOfCat[i].isEmpty
                    ? Text(
                        fetchOrgName(i).tr(),
                        style: tileTextTitleStyle,
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CustomMailContainer(
                          onTap: () {
                            navigateToMailDetails(mailsOfCat[i][index]);
                          },
                          organizationName:
                              mailsOfCat[i][index].sender!.name ?? "",
                          color: hexToColor(
                              mailsOfCat[i][index].status!.color ?? ''),
                          date: mailsOfCat[i][index].archiveDate ?? "",
                          description: mailsOfCat[i][index].description ?? "",
                          images: mailsOfCat[i][index].attachments ?? [],
                          tags: mailsOfCat[i][index].tags ?? [],
                          subject: mailsOfCat[i][index].subject ?? "",
                          endMargin: 8,
                        ),
                      ],
                    );
                  },
                  itemCount: mailsOfCat[i].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            );
          },
          itemCount: 4,
          shrinkWrap: true,
        ),
      ),
    ));
  }

  /**
   *  CustomMailContainer(
      onTap: () {
      navigateToMailDetails(widget.mailsList[index]);
      },
      organizationName: widget.mailsList[index].sender!.name ?? "",
      color: hexToColor(widget.mailsList[index].status!.color ?? ''),
      date: widget.mailsList[index].archiveDate ?? "",
      description: widget.mailsList[index].description ?? "",
      images: widget.mailsList[index].attachments,
      tags: widget.mailsList[index].tags ?? [],
      subject: widget.mailsList[index].subject ?? "",
      endMargin: 8,
      ),
   */
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

          );
        },
      ),
    );
  }
}
