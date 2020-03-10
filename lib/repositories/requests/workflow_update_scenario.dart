// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);

import 'dart:convert';

String workflowUpdateScenarioToJson(WorkflowUpdateScenario data) =>
    json.encode(data.toJson());

class WorkflowUpdateScenario {
  int workflowScenarioId = 0;

  WorkflowUpdateScenario({this.workflowScenarioId});

  Map<String, dynamic> toJson() => {
        "workflow_scenario_id": workflowScenarioId,
      };
}
