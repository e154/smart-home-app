// To parse this JSON data, do
//
//     final workflow = workflowShortFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

import 'workflow_scenario.dart';
import 'workflow_scenario_short.dart';

WorkflowShort workflowShortFromJson(String str) =>
    WorkflowShort.fromJson(json.decode(str));

String workflowShortToJson(WorkflowShort data) => json.encode(data.toJson());

class WorkflowShort {
  int id;
  String name, description, status;
  WorkflowScenarioShort scenario;
  List<WorkflowScenarioShort> scenarios;
  DateTime createdAt, updatedAt;

  WorkflowShort({
    this.id,
    this.name,
    this.description,
    this.scenario,
    this.status,
    this.scenarios,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkflowShort.fromJson(Map<String, dynamic> json) {
    WorkflowScenarioShort scenario;
    if (json["scenario"] != null) {
      scenario = WorkflowScenarioShort.fromJson(json["scenario"]);
    }

    List<WorkflowScenarioShort> scenarios;
    if (json["scenarios"] != null) {
      scenarios = (json["scenarios"] as List)
          .map((s) => WorkflowScenarioShort.fromJson(s))
          .toList();
    }

    WorkflowShort workflow = new WorkflowShort(
      id: json["id"] as int,
      name: json["name"] as String,
      description: json["description"] as String,
      status: json["status"] as String,
      scenario: scenario,
      scenarios: scenarios,
      createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
      updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
    );
    return workflow;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "scenario": scenario,
        "status": status,
        "scenarios": scenarios,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
