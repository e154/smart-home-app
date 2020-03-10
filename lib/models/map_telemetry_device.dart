// To parse this JSON data, do
//
//     final mapTelemetryDevice = mapTelemetryDeviceFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/models.dart';

MapTelemetryDevice mapTelemetryDeviceFromJson(String str) =>
    MapTelemetryDevice.fromJson(json.decode(str));

class MapTelemetryDevice {
  int id, statusId;
  String elementName;
  dynamic options;

  MapTelemetryDevice({
    this.id,
    this.statusId,
    this.options,
    this.elementName,
  });

  factory MapTelemetryDevice.fromJson(Map<String, dynamic> json) {
    return MapTelemetryDevice(
      id: json["id"] as int,
      statusId: json["status_id"] as int,
      options: (json["options"] == null) ? null : json["options"],
      elementName: json["element_name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_id": statusId,
        "options": options,
        "element_name": elementName,
      };
}
