// To parse this JSON data, do
//
//     final script = scriptFromJson(jsonString);

import 'dart:convert';

Script scriptFromJson(String str) => Script.fromJson(json.decode(str));

String scriptToJson(Script data) => json.encode(data.toJson());

class Script {
  String id;
  String lang;
  String name;
  String source;
  String description;

  Script({
    this.id,
    this.lang,
    this.name,
    this.source,
    this.description,
  });

  factory Script.fromJson(Map<String, dynamic> json) => new Script(
    id: json["id"],
    lang: json["lang"],
    name: json["name"],
    source: json["source"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lang": lang,
    "name": name,
    "source": source,
    "description": description,
  };
}
