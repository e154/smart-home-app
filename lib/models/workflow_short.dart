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
//     final workflow = workflowShortFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

import 'workflow_scenario.dart';
import 'workflow_scenario_short.dart';

WorkflowShort workflowShortFromJson(String str) =>
    WorkflowShort.fromJson(json.decode(str));

String workflowShortToJson(WorkflowShort data) => json.encode(data.toJson());

class WorkflowShort {
  int id;
  String name, description, status;
  WorkflowScenarioShort scenario;
  List<WorkflowScenarioShort> scenarios;
  DateTime createdAt, updatedAt;

  WorkflowShort({
    this.id,
    this.name,
    this.description,
    this.scenario,
    this.status,
    this.scenarios,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkflowShort.fromJson(Map<String, dynamic> json) {
    WorkflowScenarioShort scenario;
    if (json["scenario"] != null) {
      scenario = WorkflowScenarioShort.fromJson(json["scenario"]);
    }

    List<WorkflowScenarioShort> scenarios;
    if (json["scenarios"] != null) {
      scenarios = (json["scenarios"] as List)
          .map((s) => WorkflowScenarioShort.fromJson(s))
          .toList();
    }

    WorkflowShort workflow = new WorkflowShort(
      id: json["id"] as int,
      name: json["name"] as String,
      description: json["description"] as String,
      status: json["status"] as String,
      scenario: scenario,
      scenarios: scenarios,
      createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
      updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
    );
    return workflow;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "scenario": scenario,
        "status": status,
        "scenarios": scenarios,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
