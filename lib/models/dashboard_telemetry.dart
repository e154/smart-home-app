/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home-app
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

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
import 'package:smart_home_app/models/telemetry_workflow.dart';

DashboardTelemetry dashboardTelemetryFromJson(String str) =>
    DashboardTelemetry.fromJson(json.decode(str));

class DashboardTelemetry extends ResponsePayload {
  TelemetryCpu cpu;
  TelemetryMemory memory;
  TelemetryUptime uptime;
  TelemetryGate gate;
  TelemetryDevice device;
  List<TelemetryDevice> devices;
  TelemetryWorkflow workflow;

  DashboardTelemetry({
    this.cpu,
    this.memory,
    this.uptime,
    this.gate,
    this.device,
    this.devices,
    this.workflow,
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
      workflow: (json['workflows'] != null)? TelemetryWorkflow.fromJson(json["workflows"]): null,
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
    "workflow": workflow,
  };
}
