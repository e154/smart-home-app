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
//     final telemetryDevice = telemetryDeviceFromJson(jsonString);

import 'dart:convert';

TelemetryDevice telemetryDeviceFromJson(String str) =>
    TelemetryDevice.fromJson(json.decode(str));

String telemetryDeviceToJson(TelemetryDevice data) =>
    json.encode(data.toJson());

class TelemetryDevice {
  int id, deviceId;
  String description, systemName;

  TelemetryDevice({
    this.id,
    this.description,
    this.systemName,
    this.deviceId,
  });

  factory TelemetryDevice.fromJson(Map<String, dynamic> json) =>
      TelemetryDevice(
        id: json["id"] as int,
        description: json["description"],
        systemName: json["system_name"],
        deviceId: json["device_id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "system_name": systemName,
        "device_id": deviceId,
      };
}
