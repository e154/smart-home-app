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
//     final userSettings = userSettingsFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

UserSettings userSettingsFromJson(String str) => UserSettings.fromJson(json.decode(str));

String userSettingsToJson(UserSettings data) => json.encode(data.toJson());

class UserSettings {
  int id, userId, workflowId, autoload;
  String serverAddress;
  List<int> scenarios, actions;
  DateTime createdAt, updatedAt;

  UserSettings({
    this.id,
    this.userId,
    this.workflowId,
    this.autoload,
    this.scenarios,
    this.actions,
    this.serverAddress,
    this.createdAt,
    this.updatedAt,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return new UserSettings(
      id: json["id"] as int,
      userId: json["user_id"] as int,
      workflowId: json["workflow_id"] as int,
      autoload: json["autoload"] as int,
      scenarios: json["scenarios"] as List<int>,
      actions: json["actions"] as List<int>,
      serverAddress: json["server_address"],
      createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
      updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "workflow_id": workflowId,
        "autoload": autoload,
        "scenarios": scenarios,
        "actions": actions,
        "server_address": serverAddress,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
