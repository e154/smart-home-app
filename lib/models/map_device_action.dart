/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home-app
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

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
  int id, deviceActionId, mapDeviceId, deviceId;
  String name, description;
  ServerImage image;

  MapDeviceAction({
    this.id,
    this.name,
    this.description,
    this.deviceActionId,
    this.image,
    this.mapDeviceId,
    this.deviceId,
  });

  factory MapDeviceAction.fromJson(Map<String, dynamic> json) {
    return MapDeviceAction(
      id: json["id"] as int,
      name: json["name"],
      description: json["description"],
      deviceActionId: json["device_action_id"] as int,
      image: ServerImage.fromJson(json["image"]),
      mapDeviceId: json["map_device_id"] as int,
      deviceId: json["device_id"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "device_action_id": deviceActionId,
        "image": image,
        "map_device_id": mapDeviceId,
        "device_id": deviceId,
      };
}
