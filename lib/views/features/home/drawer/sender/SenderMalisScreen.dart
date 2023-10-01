import 'package:consulting_app_pailmail/repositories/sender_repository.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_app_bar.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../models/senders/senderMails.dart';
import '../../../inbox_mails/inbox_screen.dart';

class SenderMailsScreen extends StatefulWidget {
  SenderMailsScreen({super.key, this.mailsList});

  final dynamic? mailsList;

  @override
  State<SenderMailsScreen> createState() => _SenderMailsScreenState();
}

class _SenderMailsScreenState extends State<SenderMailsScreen> {
  Color hexToColor(String hexString, {String alphaChannel = 'ff'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  SenderRepository _senderRepository = SenderRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          children: [
            CustomAppBar(widgetName: "Mails of Sender", bottomPadding: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return CustomMailContainer(
                    onTap: () {
                      navigateToMailDetails(widget.mailsList[index]);
                    },
                    organizationName:
                        widget.mailsList[index].sender!.name ?? "",
                    color:
                        hexToColor(widget.mailsList[index].status!.color ?? ''),
                    date: widget.mailsList[index].archiveDate ?? "",
                    description: widget.mailsList[index].description ?? "",
                    images: [],
                    tags: [],
                    subject: widget.mailsList[index].subject ?? "",
                    endMargin: 8,
                  );
                },
                itemCount: widget.mailsList.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  navigateToMailDetails(Mails mail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return InboxScreen(
            isDetails: true,
            mails: mail,
            IsSender: true,
          );
        },
      ),
    );
  }
}
