// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'package:smart_home_app/common/common.dart';

import 'models.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String nickname, firstName, lastName, email, lang;
  DateTime createdAt, updatedAt, currentSignInAt, lastSignInAt;
  List<UserHistory> history;
  ServerImage image;
  int signInCount;
  List<UserMeta> meta;
  Role role;

  User();

  factory User.fromJson(Map<String, dynamic> json) {
    User user = new User();

    user.id = json["id"];
    user.nickname = json["nickname"];
    user.email = json["email"];
    user.firstName = json["first_name"];
    user.lastName = json["last_name"];
    user.signInCount = json["sign_in_count"];
    user.lang = json["lang"];
    user.history =
        (json["history"] as List).map((i) => UserHistory.fromJson(i)).toList();
    user.meta =
        json["meta"] != null ? (json["meta"] as List).map((i) => UserMeta.fromJson(i)).toList() : null;
    user.image = json["image"] != null ? ServerImage.fromJson(json["image"]) : null;
    user.role = Role.fromJson(json["role"]);
    user.createdAt = DateTime.parse(ignoreSubMicro(json["created_at"]));
    user.updatedAt = DateTime.parse(ignoreSubMicro(json["updated_at"]));
    user.currentSignInAt = DateTime.parse(ignoreSubMicro(json["current_sign_in_at"]));
    user.lastSignInAt = DateTime.parse(ignoreSubMicro(json["last_sign_in_at"]));

    return user;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "first_name": firstName,
        "first_name": lastName,
        "email": email,
        "image": image,
        "sign_in_count": signInCount,
        "lang": lang,
        "history": history,
        "meta": meta,
        "role": role,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "last_sign_in_at": lastSignInAt,
        "current_sign_in_at": currentSignInAt,
      };
}
