// To parse this JSON data, do
//
//     final workflowScenario = workflowScenarioShortFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

WorkflowScenarioShort workflowScenarioShortFromJson(String str) =>
    WorkflowScenarioShort.fromJson(json.decode(str));

String workflowScenarioShortToJson(WorkflowScenarioShort data) =>
    json.encode(data.toJson());

class WorkflowScenarioShort {
  int id;
  String name, systemName;
  DateTime createdAt, updatedAt;

  WorkflowScenarioShort({
    this.id,
    this.name,
    this.systemName,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkflowScenarioShort.fromJson(Map<String, dynamic> json) =>
      new WorkflowScenarioShort(
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
