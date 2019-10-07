// To parse this JSON data, do
//
//     final commandGetDevicesStates = commandGetDevicesStatesFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/repositories/server_stream/commanddart';

String commandGetDevicesStatesToJson(CommandGetDevicesStates data) =>
    json.encode(data.toJson());

class CommandGetDevicesStates extends Command {
  CommandGetDevicesStates();

  @override
  Map<String, dynamic> toJson() => {};

  String command() {
    return 'map.get.devices.states';
  }
}
