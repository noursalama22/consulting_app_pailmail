import '../categories/category.dart';

class Sender {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  String? mailsCount;
  String? message;
  Category? category;

  Sender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.mailsCount,
    this.category,
    this.message,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        mailsCount: json["mails_count"],
        message: json["message"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "mails_count": mailsCount,
        "message": message,
        "category": category?.toJson(),
      };
}
