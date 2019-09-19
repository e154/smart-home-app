// To parse this JSON data, do
//
//     final commandDoAction = commandDoActionFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/repositories/server_stream/payload.dart';

String commandDoActionToJson(CommandDoAction data) =>
    json.encode(data.toJson());

class CommandDoAction extends Payload {
  int actionId, deviceId;

  CommandDoAction({
    this.actionId,
    this.deviceId,
  });

  @override
  Map<String, dynamic> toJson() => {
        "action_id": actionId,
        "device_id": deviceId,
      };
}
