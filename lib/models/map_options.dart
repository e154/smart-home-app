// To parse this JSON data, do
//
//     final mapOptions = mapOptionsFromJson(jsonString);

import 'dart:convert';

MapOptions mapOptionsFromJson(String str) =>
    MapOptions.fromJson(json.decode(str));

String mapOptionsToJson(MapOptions data) => json.encode(data.toJson());

class MapOptions {
  int zoom;
  bool elementStateText, elementOptionText;

  MapOptions({
    this.zoom,
    this.elementStateText,
    this.elementOptionText,
  });

  factory MapOptions.fromJson(Map<String, dynamic> json) => new MapOptions(
        zoom: json["zoom"],
        elementStateText: json["element_state_text"],
        elementOptionText: json["element_option_text"],
      );

  Map<String, dynamic> toJson() => {
        "zoom": zoom,
        "element_state_text": elementStateText,
        "element_option_text": elementOptionText,
      };
}
