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
