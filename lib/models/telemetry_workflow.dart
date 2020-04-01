// To parse this JSON data, do
//
//     final telemetryWorkflow = telemetryWorkflowFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/telemetry_workflow_scenario.dart';

TelemetryWorkflow telemetryWorkflowFromJson(String str) =>
    TelemetryWorkflow.fromJson(json.decode(str));

String telemetryWorkflowToJson(TelemetryWorkflow data) =>
    json.encode(data.toJson());

class TelemetryWorkflow {
  int total, disabled;
  Map<int, TelemetryWorkflowScenario> status;

  TelemetryWorkflow({
    this.total,
    this.disabled,
    this.status,
  });

  factory TelemetryWorkflow.fromJson(Map<String, dynamic> json) {
    var status = new Map<int, TelemetryWorkflowScenario>();

    (json["status"] as Map).forEach((k, item) {
      final workflowId = int.parse(k);
      status[workflowId] = TelemetryWorkflowScenario.fromJson(item);
    });

    return TelemetryWorkflow(
      total: json["total"] as int,
      disabled: json["disabled"] as int,
      status: status,
    );
  }

  Map<String, dynamic> toJson() => {
        "total": total,
        "disabled": disabled,
      };
}
