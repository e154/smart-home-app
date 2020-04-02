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
