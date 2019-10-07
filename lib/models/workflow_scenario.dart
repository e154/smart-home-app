// To parse this JSON data, do
//
//     final workflowScenario = workflowScenarioFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

import 'script.dart';

WorkflowScenario workflowScenarioFromJson(String str) => WorkflowScenario.fromJson(json.decode(str));

String workflowScenarioToJson(WorkflowScenario data) => json.encode(data.toJson());

class WorkflowScenario {
  int id, workflowId;
  String name, systemName;
  List<Script> scripts;
  DateTime createdAt, updatedAt;

  WorkflowScenario({
    this.id,
    this.workflowId,
    this.name,
    this.systemName,
    this.scripts,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkflowScenario.fromJson(Map<String, dynamic> json) {
    final scripts =
        (json["scripts"] as List).map((f) => Script.fromJson(f)).toList();
    return new WorkflowScenario(
      id: json["id"] as int,
      workflowId: json["workflow_id"] as int,
      name: json["name"] as String,
      systemName: json["system_name"] as String,
      scripts: scripts,
      createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
      updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "workflow_id": workflowId,
        "name": name,
        "system_name": systemName,
        "scripts": scripts,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
