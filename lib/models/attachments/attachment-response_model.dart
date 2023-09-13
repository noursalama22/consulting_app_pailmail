// To parse this JSON data, do
//
//     final attachmentResponseModel = attachmentResponseModelFromJson(jsonString);

import 'dart:convert';

import 'attachment.dart';

AttachmentResponseModel attachmentResponseModelFromJson(String str) =>
    AttachmentResponseModel.fromJson(json.decode(str));

String attachmentResponseModelToJson(AttachmentResponseModel data) =>
    json.encode(data.toJson());

class AttachmentResponseModel {
  String? message;
  Attachment? attachment;

  AttachmentResponseModel({
    this.message,
    this.attachment,
  });

  factory AttachmentResponseModel.fromJson(Map<String, dynamic> json) =>
      AttachmentResponseModel(
        message: json["message"],
        attachment: json["attachment"] == null
            ? null
            : Attachment.fromJson(json["attachment"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "attachment": attachment?.toJson(),
      };
}
