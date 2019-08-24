// To parse this JSON data, do
//
//     final variable = variableFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

Variable variableFromJson(String str) => Variable.fromJson(json.decode(str));

String variableToJson(Variable data) => json.encode(data.toJson());

class Variable {
  String name, value;
  bool autoload;
  DateTime createdAt, updatedAt;

  Variable({
    this.name,
    this.value,
    this.autoload,
    this.createdAt,
    this.updatedAt,
  });

  factory Variable.fromJson(Map<String, dynamic> json) => new Variable(
        name: json["name"],
        value: json["value"],
        autoload: json["autoload"],
        createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
        updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "autoload": autoload,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
