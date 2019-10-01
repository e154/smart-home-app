// To parse this JSON data, do
//
//     final telemetryGate = telemetryGateFromJson(jsonString);

import 'dart:convert';

TelemetryGate telemetryGateFromJson(String str) => TelemetryGate.fromJson(json.decode(str));

String telemetryGateToJson(TelemetryGate data) => json.encode(data.toJson());

class TelemetryGate {
  String status;

  TelemetryGate({
    this.status,
  });

  factory TelemetryGate.fromJson(Map<String, dynamic> json) => TelemetryGate(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
