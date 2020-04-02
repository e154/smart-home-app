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
//     final workflowScenario = workflowScenarioFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

import 'script.dart';

WorkflowScenario workflowScenarioFromJson(String str) => WorkflowScenario.fromJson(json.decode(str));

String workflowScenarioToJson(WorkflowScenario data) => json.encode(data.toJson());

class WorkflowScenario {
  int id, workflowId;
  String name, systemName;
  List<Script> scripts;
  DateTime createdAt, updatedAt;

  WorkflowScenario({
    this.id,
    this.workflowId,
    this.name,
    this.systemName,
    this.scripts,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkflowScenario.fromJson(Map<String, dynamic> json) {
    final scripts =
        (json["scripts"] as List).map((f) => Script.fromJson(f)).toList();
    return new WorkflowScenario(
      id: json["id"] as int,
      workflowId: json["workflow_id"] as int,
      name: json["name"] as String,
      systemName: json["system_name"] as String,
      scripts: scripts,
      createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
      updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "workflow_id": workflowId,
        "name": name,
        "system_name": systemName,
        "scripts": scripts,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
