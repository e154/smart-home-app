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

    if (json['status'] != null) {
      (json["status"] as Map).forEach((k, item) {
        final workflowId = int.parse(k);
        status[workflowId] = TelemetryWorkflowScenario.fromJson(item);
      });
    }

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
