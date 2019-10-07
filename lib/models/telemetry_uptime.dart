// To parse this JSON data, do
//
//     final telemetryUptime = telemetryUptimeFromJson(jsonString);

import 'dart:convert';

TelemetryUptime telemetryUptimeFromJson(String str) => TelemetryUptime.fromJson(json.decode(str));

String telemetryUptimeToJson(TelemetryUptime data) => json.encode(data.toJson());

class TelemetryUptime {
  int total, idle;

  TelemetryUptime({
    this.total,
    this.idle,
  });

  factory TelemetryUptime.fromJson(Map<String, dynamic> json) => TelemetryUptime(
    total: json["total"] as int,
    idle: json["idle"] as int,
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "idle": idle,
  };
}
