// To parse this JSON data, do
//
//     final mapTelemetryDeviceStat = mapTelemetryDeviceStatFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/models.dart';

MapTelemetryDeviceState mapTelemetryDeviceStatFromJson(String str) =>
    MapTelemetryDeviceState.fromJson(json.decode(str));

class MapTelemetryDeviceState {
  int id, deviceId;
  String description, systemName;

  MapTelemetryDeviceState({
    this.id,
    this.deviceId,
    this.description,
    this.systemName,
  });

  factory MapTelemetryDeviceState.fromJson(Map<String, dynamic> json) {
    return MapTelemetryDeviceState(
      id: json["id"] as int,
      deviceId: json["device_id"] as int,
      description: json["description"],
      systemName: json["system_name"],
    );
  }
}
