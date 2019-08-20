// To parse this JSON data, do
//
//     final userMeta = userMetaFromJson(jsonString);

import 'dart:convert';

UserMeta userMetaFromJson(String str) => UserMeta.fromJson(json.decode(str));

String userMetaToJson(UserMeta data) => json.encode(data.toJson());

class UserMeta {
  String key;
  String value;

  UserMeta({
    this.key,
    this.value,
  });

  factory UserMeta.fromJson(Map<String, dynamic> json) => new UserMeta(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
