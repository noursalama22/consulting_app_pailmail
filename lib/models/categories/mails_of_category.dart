// To parse this JSON data, do
//
//     final mailsOfCategory = mailsOfCategoryFromJson(jsonString);

import 'dart:convert';

import '../mails/mail.dart';

MailsOfCategory mailsOfCategoryFromJson(String str) =>
    MailsOfCategory.fromJson(json.decode(str));

String mailsOfCategoryToJson(MailsOfCategory data) =>
    json.encode(data.toJson());

class MailsOfCategory {
  List<Mail>? mails;

  MailsOfCategory({
    this.mails,
  });

  factory MailsOfCategory.fromJson(Map<String, dynamic> json) =>
      MailsOfCategory(
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
      };
}
