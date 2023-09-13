// To parse this JSON data, do
//
//     final statusResponseModel = statusResponseModelFromJson(jsonString);

import 'dart:convert';

import '../mails/mail.dart';

StatusResponseModel statusResponseModelFromJson(String str) =>
    StatusResponseModel.fromJson(json.decode(str));

String statusResponseModelToJson(StatusResponseModel data) =>
    json.encode(data.toJson());

class StatusResponseModel {
  StatusResponseModelStatus? status;

  StatusResponseModel({
    this.status,
  });

  factory StatusResponseModel.fromJson(Map<String, dynamic> json) =>
      StatusResponseModel(
        status: json["status"] == null
            ? null
            : StatusResponseModelStatus.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
      };
}

class StatusResponseModelStatus {
  int? id;
  String? name;
  String? color;
  String? createdAt;
  String? updatedAt;
  String? mailsCount;
  List<Mail>? mails;

  StatusResponseModelStatus({
    this.id,
    this.name,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.mailsCount,
    this.mails,
  });

  factory StatusResponseModelStatus.fromJson(Map<String, dynamic> json) =>
      StatusResponseModelStatus(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        mailsCount: json["mails_count"],
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "mails_count": mailsCount,
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
      };
}
