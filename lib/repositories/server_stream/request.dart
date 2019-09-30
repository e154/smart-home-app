// To parse this JSON data, do
//
//     final request = requestFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/repositories/server_stream/payload.dart';

String requestToJson(Request data) => json.encode(data.toJson());

class Request {
  String id;
  String command;
  Payload payload;

  Request({
    this.id,
    this.command,
    this.payload,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "command": command,
        "payload": payload.toJson(),
      };
}