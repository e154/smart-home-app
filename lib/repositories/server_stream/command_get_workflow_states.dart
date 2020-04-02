// To parse this JSON data, do
//
//     final commandGetWorkflowStates = commandGetWorkflowStatesFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/repositories/server_stream/command.dart';

String commandGetWorkflowStatesToJson(CommandGetWorkflowStates data) =>
    json.encode(data.toJson());

class CommandGetWorkflowStates extends Command {
  CommandGetWorkflowStates();

  @override
  Map<String, dynamic> toJson() => {};

  String command() {
    return 'workflow.get.status';
  }
}
