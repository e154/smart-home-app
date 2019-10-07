// To parse this JSON data, do
//
//     final telemetryCpu = telemetryCpuFromJson(jsonString);

import 'dart:convert';

TelemetryCpu telemetryCpuFromJson(String str) => TelemetryCpu.fromJson(json.decode(str));

String telemetryCpuToJson(TelemetryCpu data) => json.encode(data.toJson());

class TelemetryCpu {
  double all;

  TelemetryCpu({
    this.all,
  });

  factory TelemetryCpu.fromJson(Map<String, dynamic> json) => TelemetryCpu(
    all: json["all"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}
