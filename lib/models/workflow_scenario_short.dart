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
//     final workflowScenario = workflowScenarioShortFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

WorkflowScenarioShort workflowScenarioShortFromJson(String str) =>
    WorkflowScenarioShort.fromJson(json.decode(str));

String workflowScenarioShortToJson(WorkflowScenarioShort data) =>
    json.encode(data.toJson());

class WorkflowScenarioShort {
  int id;
  String name, systemName;
  DateTime createdAt, updatedAt;

  WorkflowScenarioShort({
    this.id,
    this.name,
    this.systemName,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkflowScenarioShort.fromJson(Map<String, dynamic> json) =>
      new WorkflowScenarioShort(
        id: json["id"] as int,
        name: json["name"] as String,
        systemName: json["system_name"] as String,
        createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
        updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "system_name": systemName,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
