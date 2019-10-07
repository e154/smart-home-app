// To parse this JSON data, do
//
//     final role = roleFromJson(jsonString);

import 'dart:convert';

Role roleFromJson(String str) => Role.fromJson(json.decode(str));

String roleToJson(Role data) => json.encode(data.toJson());

class Role {
  String name;
  Map<String, List<String>> accessList;
  String description;

  Role();

  factory Role.fromJson(Map<String, dynamic> json) {
    Role role = new Role();
    role.name = json["name"];
//    role.accessList = json["access_list"] != null ? (json["access_list"] as List).map((f)=> ...);
    role.description = json["description"];

    return role;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "access_list": accessList,
        "description": description,
      };
}
