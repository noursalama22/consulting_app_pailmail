import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/providers/mails_provider_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestEmails extends StatefulWidget {
  const TestEmails({Key? key}) : super(key: key);

  @override
  State<TestEmails> createState() => _TestEmailsState();
}

class _TestEmailsState extends State<TestEmails> {
  late ApiResponse<bool> mail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Consumer<MailProvider>(
          //   builder: (context, mailProvider, child) {
          //     if (mailProvider.mails.status == ApiStatus.LOADING) {
          //       {
          //         return const CircularProgressIndicator();
          //       }
          //     } else if (mailProvider.mails.status == ApiStatus.COMPLETED) {
          //       {
          //         return Expanded(
          //           child: ListView.builder(
          //             shrinkWrap: true,
          //             itemBuilder: (context, index) {
          //               final mail = mailProvider.mails.data![index].subject;
          //               return Row(
          //                 children: [
          //                   Container(
          //                     child: Text(mail.toString()),
          //                   ),
          //                 ],
          //               );
          //             },
          //             itemCount: mailProvider.mails.data!.length,
          //           ),
          //         );
          //       }
          //     } else {
          //       return Text(mailProvider.mails.message.toString());
          //     }
          //   },
          // ),
          Divider(),
          // Consumer<MailProvider>(
          //   builder: (context, mailProvider, child) {
          //     if (mailProvider.mails.status == ApiStatus.LOADING) {
          //       {
          //         return const CircularProgressIndicator();
          //       }
          //     } else if (mailProvider.mails.status == ApiStatus.COMPLETED) {
          //       {
          //         final mail = mailProvider.mails.data![0].activities![0].body;
          //         return Center(
          //           child: Row(
          //             children: [
          //               Container(
          //                 child: Text(mail.toString()),
          //               ),
          //             ],
          //           ),
          //         );
          //       }
          //     } else {
          //       return Text(mailProvider.mails.message.toString());
          //     }
          //   },
          // ),
          // ElevatedButton(
          //   onPressed: () async {
          //     await MailProvider().deleteEmail(id: "1");
          //   },
          //   child: Consumer<MailProvider>(
          //     builder: (context, mailProvider, child) {
          //       if (mailProvider.deleted.status == ApiStatus.LOADING) {
          //         {
          //           return const CircularProgressIndicator();
          //         }
          //       } else if (mailProvider.deleted.status == ApiStatus.COMPLETED) {
          //         {
          //           final mail = mailProvider.deleted;
          //           return Center(
          //             child: Row(
          //               children: [
          //                 Container(
          //                   child: Text(mail.toString()),
          //                 ),
          //               ],
          //             ),
          //           );
          //         }
          //       } else {
          //         return Text(mailProvider.deleted.message.toString());
          //       }
          //     },
          //   ),
          // )
          Consumer<MailProvider>(
            builder: (context, mailProvider, child) {
              final mail = mailProvider.mails.data?.last.id;
              if (mailProvider.mails.status == ApiStatus.LOADING) {
                {
                  return const CircularProgressIndicator();
                }
              } else if (mailProvider.mails.status == ApiStatus.COMPLETED) {
                {
                  return Center(
                    child: Row(
                      children: [
                        Container(
                          child: Text(mail.toString()),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Text(mailProvider.mails.message.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}
