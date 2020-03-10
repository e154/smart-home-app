// To parse this JSON data, do
//
//     final telemetryWorkflow = telemetryWorkflowFromJson(jsonString);

import 'dart:convert';

TelemetryWorkflow telemetryWorkflowFromJson(String str) =>
    TelemetryWorkflow.fromJson(json.decode(str));

String telemetryWorkflowToJson(TelemetryWorkflow data) =>
    json.encode(data.toJson());

class TelemetryWorkflow {
  int id, deviceId;
  String description, systemName;

  TelemetryWorkflow({
    this.id,
    this.description,
    this.systemName,
    this.deviceId,
  });

  factory TelemetryWorkflow.fromJson(Map<String, dynamic> json) =>
      TelemetryWorkflow(
        id: json["id"] as int,
        description: json["description"],
        systemName: json["system_name"],
        deviceId: json["device_id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "system_name": systemName,
        "device_id": deviceId,
      };
}
