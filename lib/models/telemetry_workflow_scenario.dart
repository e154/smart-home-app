// To parse this JSON data, do
//
//     final telemetryWorkflow = telemetryWorkflowFromJson(jsonString);

import 'dart:convert';

class TelemetryWorkflowScenario {
  int id, scenarioId;

  TelemetryWorkflowScenario({this.id, this.scenarioId});

  factory TelemetryWorkflowScenario.fromJson(Map<String, dynamic> json) =>
      TelemetryWorkflowScenario(
        id: json["id"] as int,
        scenarioId: json["scenario_id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "scenario_id": scenarioId,
      };
}
