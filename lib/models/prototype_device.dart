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
//     final prototypeDevice = prototypeDeviceFromJson(jsonString);

import 'dart:convert';
import 'package:smart_home_app/models/map_device_action.dart';
import 'package:smart_home_app/models/map_device_state.dart';
import 'package:smart_home_app/models/server_image.dart';
import 'package:smart_home_app/models/prototype.dart';

PrototypeDevice prototypeDeviceFromJson(String str) =>
    PrototypeDevice.fromJson(json.decode(str));

String prototypeDeviceToJson(PrototypeDevice data) =>
    json.encode(data.toJson());

class PrototypeDevice extends Prototype {
  int id, deviceId, imageId;
  String systemName;
  ServerImage serverImage;
  List<MapDeviceAction> actions;
  List<MapDeviceState> states;

  PrototypeDevice({
    this.id,
    this.deviceId,
    this.imageId,
    this.systemName,
    this.serverImage,
    this.actions,
    this.states,
  });

  factory PrototypeDevice.fromJson(Map<String, dynamic> json) =>
      PrototypeDevice(
        id: json["id"] as int,
        deviceId: json["device_id"] as int,
        imageId: json["image_id"] as int,
        systemName: json["system_name"],
        serverImage: ServerImage.fromJson(json["image"]),
        actions: (json["actions"] as List)
            .map((action) => MapDeviceAction.fromJson(action))
            .toList(),
        states: (json["states"] as List)
            .map((action) => MapDeviceState.fromJson(action))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_id": deviceId,
        "image_id": imageId,
        "system_name": systemName,
        "server_image": serverImage,
        "actions": actions,
        "states": states,
      };
}
