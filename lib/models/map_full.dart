// To parse this JSON data, do
//
//     final mapFull = mapFullFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

MapFull mapFullFromJson(String str) => MapFull.fromJson(json.decode(str));

String mapFullToJson(MapFull data) => json.encode(data.toJson());

class MapFull {
  int id;
  String name, description;
  DateTime createdAt, updatedAt;

  MapFull({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MapFull.fromJson(Map<String, dynamic> json) => new MapFull(
    id: json["id"] as int,
    name: json["name"] as String,
    description: json["description"] as String,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
