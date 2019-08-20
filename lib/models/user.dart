// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/user_history.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String nickname;
  String firstName;
  String lastName;
  String email;
  DateTime createdAt;
  DateTime updatedAt;

//  List<UserHistory> history;

  User({
    this.id,
    this.nickname,
    this.firstName,
    this.lastName,
    this.email,
    this.createdAt,
    this.updatedAt,
//    this.history,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        nickname: json["nickname"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
//        history: (json["history"] as List)
//            .map((i) => UserHistory.fromJson(i))
//            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "first_name": firstName,
        "first_name": lastName,
        "email": email,
//        "history": history,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
