// To parse this JSON data, do
//
//     final mapDeviceState = mapDeviceStateFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/models.dart';

MapDeviceState mapDeviceStateFromJson(String str) =>
    MapDeviceState.fromJson(json.decode(str));

String mapDeviceStateToJson(MapDeviceState data) => json.encode(data.toJson());

class MapDeviceState {
  int id, mapDeviceId, deviceStateId, deviceId;
  String systemName, description, style;
  ServerImage image;

  MapDeviceState({
    this.id,
    this.systemName,
    this.description,
    this.deviceStateId,
    this.image,
    this.style,
    this.mapDeviceId,
    this.deviceId,
  });

  factory MapDeviceState.fromJson(Map<String, dynamic> json) => MapDeviceState(
        id: json["id"] as int,
        systemName: json["system_name"],
        description: json["description"],
        deviceStateId: json["device_state_id"] as int,
        image: ServerImage.fromJson(json["image"]),
        style: json["style"],
        mapDeviceId: json["map_device_id"] as int,
        deviceId: json["device_id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "system_name": systemName,
        "description": description,
        "device_state_id": deviceStateId,
        "image": image,
        "style": style,
        "map_device_id": mapDeviceId,
        "device_id": deviceId,
      };
}
