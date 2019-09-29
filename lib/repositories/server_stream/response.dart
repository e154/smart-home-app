// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/repositories/server_stream/payload.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

class Response {
  String id, command, forward, status, type;
  Payload payload;

  Response({
    this.id,
    this.command,
    this.payload,
    this.forward,
    this.status,
    this.type,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    Payload payload;

    return Response(
      id: json["id"],
      command: json["command"] as String,
      payload: payload,
      forward: json["forward"] as String,
      status: json["status"] as String,
      type: json["type"] as String,
    );
  }
}
