// class Role {
//   dynamic id;
//   dynamic name;
//   String? createdAt;
//   String? updatedAt;
//
//   Role({this.id, this.name, this.createdAt, this.updatedAt});
//
//   Role.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
import '../users/user.dart';

class Role {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? usersCount;
  List<User>? users;

  Role({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.usersCount,
    this.users,
  });
  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
