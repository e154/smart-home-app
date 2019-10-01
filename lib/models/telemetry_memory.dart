// To parse this JSON data, do
//
//     final telemetryMemory = telemetryMemoryFromJson(jsonString);

import 'dart:convert';

TelemetryMemory telemetryMemoryFromJson(String str) =>
    TelemetryMemory.fromJson(json.decode(str));

String telemetryMemoryToJson(TelemetryMemory data) =>
    json.encode(data.toJson());

class TelemetryMemory {
  int swapTotal, swapFree, memTotal, memFree;

  TelemetryMemory({
    this.swapTotal,
    this.swapFree,
    this.memTotal,
    this.memFree,
  });

  factory TelemetryMemory.fromJson(Map<String, dynamic> json) =>
      TelemetryMemory(
        swapTotal: json["swap_total"] as int,
        swapFree: json["swap_free"] as int,
        memTotal: json["mem_total"] as int,
        memFree: json["mem_free"] as int,
      );

  Map<String, dynamic> toJson() => {
        "swap_total": swapTotal,
        "swap_free": swapFree,
        "mem_total": memTotal,
        "mem_free": memFree,
      };
}
