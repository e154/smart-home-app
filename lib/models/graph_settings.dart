// To parse this JSON data, do
//
//     final graphSettings = graphSettingsFromJson(jsonString);

import 'dart:convert';

GraphSettings graphSettingsFromJson(String str) => GraphSettings.fromJson(json.decode(str));

String graphSettingsToJson(GraphSettings data) => json.encode(data.toJson());

class GraphSettings {
  int width;
  int height;
  Position position;

  GraphSettings({
    this.width,
    this.height,
    this.position,
  });

  factory GraphSettings.fromJson(Map<String, dynamic> json) => GraphSettings(
    width: json["width"] as int,
    height: json["height"] as int,
    position: Position.fromJson(json["position"]),
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "position": position.toJson(),
  };
}

class Position {
  int top;
  int left;

  Position({
    this.top,
    this.left,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    top: json["top"] as int,
    left: json["left"] as int,
  );

  Map<String, dynamic> toJson() => {
    "top": top,
    "left": left,
  };
}
