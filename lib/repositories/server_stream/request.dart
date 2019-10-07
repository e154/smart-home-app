// To parse this JSON data, do
//
//     final request = requestFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/repositories/server_stream/commanddart';

String requestToJson(Request data) => json.encode(data.toJson());

class Request {
  String id;
  String command;
  Command payload;

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
