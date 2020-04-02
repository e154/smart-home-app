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
//     final response = responseFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/models.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

class Response {
  String id, command, forward, status, type;
  dynamic payload;

  Response({
    this.id,
    this.command,
    this.payload,
    this.forward,
    this.status,
    this.type,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    final command = json["command"];
    dynamic payload;

    switch (command) {
      case "dashboard.telemetry":
        payload = DashboardTelemetry.fromJson(json["payload"]);
        break;
      case "map.telemetry":
        payload = MapTelemetry.fromJson(json["payload"]);
        break;
      default:
        payload = json["payload"];
    }

    return Response(
      id: json["id"],
      command: command,
      payload: payload,
      forward: json["forward"],
      status: json["status"],
      type: json["type"],
    );
  }
}
