// To parse this JSON data, do
//
//     final dashboardTelemetry = dashboardTelemetryFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/models/response_payload.dart';
import 'package:smart_home_app/models/telemetry_cpu.dart';
import 'package:smart_home_app/models/telemetry_gate.dart';
import 'package:smart_home_app/models/telemetry_memory.dart';
import 'package:smart_home_app/models/telemetry_uptime.dart';

DashboardTelemetry dashboardTelemetryFromJson(String str) =>
    DashboardTelemetry.fromJson(json.decode(str));

class DashboardTelemetry extends ResponsePayload {
  TelemetryCpu cpu;
  TelemetryMemory memory;
  TelemetryUptime uptime;
  TelemetryGate gate;
  TelemetryDevice device;
  List<TelemetryDevice> devices;

  DashboardTelemetry({
    this.cpu,
    this.memory,
    this.uptime,
    this.gate,
    this.device,
    this.devices,
  });

  factory DashboardTelemetry.fromJson(Map<String, dynamic> json) {
    TelemetryDevice device;

    if (json['device'] != null) {
      device = TelemetryDevice.fromJson(json['device']);
    }

    List<TelemetryDevice> devices;
    if (json['devices']  != null) {
      devices = List<TelemetryDevice>();
      (json['devices'] as Map).forEach((k, item){
        devices.add(TelemetryDevice.fromJson(item));
      });
    }

    return DashboardTelemetry(
      cpu: (json['cpu'] != null) ? TelemetryCpu.fromJson(json['cpu']): null,
      memory: (json['memory'] != null)? TelemetryMemory.fromJson(json['memory']): null,
      uptime: (json['uptime'] != null)? TelemetryUptime.fromJson(json["uptime"]): null,
      gate: (json['gate'] != null)? TelemetryGate.fromJson(json["gate"]): null,
      device: device,
      devices: devices,
    );
  }

  Map<String, dynamic> toJson() => {
    "cpu": cpu,
    "memory": memory,
    "uptime": uptime,
    "gate": gate,
    "device": device.toJson(),
    "devices": devices,
  };
}
