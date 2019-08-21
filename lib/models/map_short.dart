// To parse this JSON data, do
//
//     final mapShort = mapShortFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

MapShort mapShortFromJson(String str) => MapShort.fromJson(json.decode(str));

String mapShortToJson(MapShort data) => json.encode(data.toJson());

class MapShort {
  String id;
  String name, description;
  DateTime createdAt, updatedAt;

  MapShort({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MapShort.fromJson(Map<String, dynamic> json) => new MapShort(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
