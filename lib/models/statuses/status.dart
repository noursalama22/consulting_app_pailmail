import '../pivot.dart';

class Status {
  int? id;
  String? name;
  String? color;
  Pivot? pivot;
  String? createdAt;
  String? updatedAt;

  Status({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.pivot,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        color: json["color"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "color": color,
        "pivot": pivot?.toJson(),
      };
}