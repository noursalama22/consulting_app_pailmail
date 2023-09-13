// To parse this JSON data, do
//
//     final senderResponseModel = senderResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:consulting_app_pailmail/models/senders/sender.dart';

SenderResponseModel senderResponseModelFromJson(String str) =>
    SenderResponseModel.fromJson(json.decode(str));

String senderResponseModelToJson(SenderResponseModel data) =>
    json.encode(data.toJson());

class SenderResponseModel {
  Sender? sender;

  SenderResponseModel({
    this.sender,
  });

  factory SenderResponseModel.fromJson(Map<String, dynamic> json) =>
      SenderResponseModel(
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender?.toJson(),
      };
}
