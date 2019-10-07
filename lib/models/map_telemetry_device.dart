// To parse this JSON data, do
//
//     final mapTelemetryDevice = mapTelemetryDeviceFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/models.dart';

MapTelemetryDevice mapTelemetryDeviceFromJson(String str) =>
    MapTelemetryDevice.fromJson(json.decode(str));

class MapTelemetryDevice {
  int id;
  MapTelemetryDeviceState status;
  dynamic options;
  String elementName;

  MapTelemetryDevice({
    this.id,
    this.status,
    this.options,
    this.elementName,
  });

  factory MapTelemetryDevice.fromJson(Map<String, dynamic> json) {
    return MapTelemetryDevice(
      id: json["id"] as int,
      status: (json["status"] != null)?MapTelemetryDeviceState.fromJson(json["status"]):null,
      options: (json["description"] == null)?null:json["description"],
      elementName: json["element_name"],
    );
  }
}
