// To parse this JSON data, do
//
//     final mapDeviceAction = mapDeviceActionFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/server_image.dart';

MapDeviceAction mapDeviceActionFromJson(String str) =>
    MapDeviceAction.fromJson(json.decode(str));

String mapDeviceActionToJson(MapDeviceAction data) =>
    json.encode(data.toJson());

class MapDeviceAction {
  int id, deviceActionId, deviceId;
  String name, description;
  ServerImage image;

  MapDeviceAction({
    this.id,
    this.name,
    this.description,
    this.deviceActionId,
    this.image,
    this.deviceId,
  });

  factory MapDeviceAction.fromJson(Map<String, dynamic> json) {
    return MapDeviceAction(
      id: json["id"] as int,
      name: json["name"],
      description: json["description"],
      deviceActionId: json["device_action_id"] as int,
      image: ServerImage.fromJson(json["image"]),
      deviceId: json["device_id"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "device_action_id": deviceActionId,
        "image": image,
        "device_id": deviceId,
      };
}
