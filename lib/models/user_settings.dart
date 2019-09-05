// To parse this JSON data, do
//
//     final userSettings = userSettingsFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

UserSettings userSettingsFromJson(String str) => UserSettings.fromJson(json.decode(str));

String userSettingsToJson(UserSettings data) => json.encode(data.toJson());

class UserSettings {
  int id, userId, workflowId, autoload;
  List<int> scenarios, actions;
  DateTime createdAt, updatedAt;

  UserSettings({
    this.id,
    this.userId,
    this.workflowId,
    this.autoload,
    this.scenarios,
    this.actions,
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
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
