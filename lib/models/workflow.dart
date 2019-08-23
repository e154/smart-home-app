// To parse this JSON data, do
//
//     final workflow = workflowFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

import 'workflow_scenario.dart';

Workflow workflowFromJson(String str) => Workflow.fromJson(json.decode(str));

String workflowToJson(Workflow data) => json.encode(data.toJson());

class Workflow {
  int id;
  String name, description, options, status;
  WorkflowScenario scenario;
  List<WorkflowScenario> scenarios;
  DateTime createdAt, updatedAt;

  Workflow({
    this.id,
    this.name,
    this.description,
    this.options,
    this.scenario,
    this.status,
    this.scenarios,
    this.createdAt,
    this.updatedAt,
  });

  factory Workflow.fromJson(Map<String, dynamic> json) {
    final scenario = WorkflowScenario.fromJson(json["scenario"]);
    final scenarios =
        (json["scenarios"] as List).map((s) => WorkflowScenario.fromJson(s));
    Workflow workflow = new Workflow(
      id: json["id"] as int,
      name: json["name"] as String,
      description: json["description"] as String,
      options: json["options"] as String,
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
        "options": options,
        "scenario": scenario,
        "status": status,
        "scenarios": scenarios,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}