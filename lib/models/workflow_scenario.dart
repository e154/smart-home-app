// To parse this JSON data, do
//
//     final workflowScenario = workflowScenarioFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

WorkflowScenario workflowScenarioFromJson(String str) =>
    WorkflowScenario.fromJson(json.decode(str));

String workflowScenarioToJson(WorkflowScenario data) =>
    json.encode(data.toJson());

class WorkflowScenario {
  int id;
  String name, systemName;
  DateTime createdAt, updatedAt;

  WorkflowScenario({
    this.id,
    this.name,
    this.systemName,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkflowScenario.fromJson(Map<String, dynamic> json) =>
      new WorkflowScenario(
        id: json["id"] as int,
        name: json["name"] as String,
        systemName: json["system_name"] as String,
        createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
        updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "system_name": systemName,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
