// To parse this JSON data, do
//
//     final commandDoAction = commandDoActionFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/repositories/server_stream/commanddart';

String commandDoActionToJson(CommandDoAction data) =>
    json.encode(data.toJson());

class CommandDoAction extends Command {
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

  String command() {
    return 'do.action';
  }
}
