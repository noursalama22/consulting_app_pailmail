import 'dart:convert';

import '../roles/role.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? emailVerifiedAt;
  dynamic roleId;
  String? createdAt;
  String? updatedAt;
  Role? role;

  User(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['roles'] != null ? new Role.fromJson(json['roles']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.role != null) {
      data['roles'] = this.role!.toJson();
    }
    return data;
  }
}
