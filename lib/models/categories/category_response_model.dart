// To parse this JSON data, do
//
//     final categoryResponseModel = categoryResponseModelFromJson(jsonString);

import 'dart:convert';

import '../senders/sender.dart';

CategoryResponseModel categoryResponseModelFromJson(String str) =>
    CategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(CategoryResponseModel data) =>
    json.encode(data.toJson());

class CategoryResponseModel {
  List<CategoryElement>? categories;

  CategoryResponseModel({
    this.categories,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryResponseModel(
        categories: json["categories"] == null
            ? []
            : List<CategoryElement>.from(
                json["categories"]!.map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class CategoryElement {
  // first 4 can be replaced with Category object
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? sendersCount;
  List<Sender>? senders;

  CategoryElement({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.sendersCount,
    this.senders,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        sendersCount: json["senders_count"],
        senders: json["senders"] == null
            ? []
            : List<Sender>.from(
                json["senders"]!.map((x) => Sender.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "senders_count": sendersCount,
        "senders": senders == null
            ? []
            : List<dynamic>.from(senders!.map((x) => x.toJson())),
      };
}
