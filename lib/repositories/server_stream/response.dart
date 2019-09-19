// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

class Response {
  String id, command, payload, forward, status, type;

  Response({
    this.id,
    this.command,
    this.payload,
    this.forward,
    this.status,
    this.type,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        command: json["command"],
        payload: json["payload"],
        forward: json["forward"],
        status: json["status"],
        type: json["type"],
      );
}
