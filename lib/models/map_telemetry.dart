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
//     final mapTelemetry = mapTelemetryFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/models/response_payload.dart';

MapTelemetry mapTelemetryFromJson(String str) =>
    MapTelemetry.fromJson(json.decode(str));

class MapTelemetry extends ResponsePayload {
  MapTelemetryDevice device;

  MapTelemetry({
    this.device,
  });

  factory MapTelemetry.fromJson(Map<String, dynamic> json) {
    return MapTelemetry(
      device: (json['device'] != null)? MapTelemetryDevice.fromJson(json['device']): null,
    );
  }

  Map<String, dynamic> toJson() => {
    "device": device.toJson(),
  };
}
