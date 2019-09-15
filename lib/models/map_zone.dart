// To parse this JSON data, do
//
//     final mapZone = mapZoneFromJson(jsonString);

import 'dart:convert';

MapZone mapZoneFromJson(String str) => MapZone.fromJson(json.decode(str));

String mapZoneToJson(MapZone data) => json.encode(data.toJson());

class MapZone {
  int id;
  String name;

  MapZone({
    this.id,
    this.name,
  });

  factory MapZone.fromJson(Map<String, dynamic> json) => MapZone(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
