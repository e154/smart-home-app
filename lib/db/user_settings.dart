import 'dart:convert';

import 'db.dart';

class UserSetting {
  int id, userId, workflowId, autoload;
  String scenarios, actions, createdAt, updatedAt;

  UserSetting({
    this.id,
    this.userId,
    this.workflowId,
    this.autoload,
    this.scenarios,
    this.actions,
    this.createdAt,
    this.updatedAt,
  });

  factory UserSetting.fromRawJson(String str) => UserSetting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSetting.fromJson(Map<String, dynamic> json) => new UserSetting(
        id: json["id"] as int,
        userId: json["user_id"] as int,
        workflowId: json["workflow_id"] == null ? null : json["workflow_id"] as int,
        autoload: json["autoload"] == null ? null : json["autoload"] as int,
        scenarios: json["scenarios"],
        actions: json["actions"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

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

class UserSettings {
  DBProvider _provider;

  UserSettings(this._provider);

  createOrUpdate(UserSetting settings) async {
    final db = await _provider.database;

    var res = await db.query("user_settings",
        where: "user_id = ? and workflow_id = ?", whereArgs: [settings.userId, settings.workflowId]);

    if (res.isEmpty) {
      var raw = await db.rawInsert(
          "INSERT Into user_settings (user_id, workflow_id, scenarios, "
          "actions, autoload, created_at)  VALUES (?,?,?,?,?,?)",
          [
            settings.userId,
            settings.workflowId,
            settings.scenarios,
            settings.actions,
            settings.autoload,
            settings.createdAt,
          ]);
      return raw;
    } else {
      var raw = await db.rawInsert(
          "UPDATE user_settings SET scenarios=?, actions=?,"
          " updated_at=?, autoload=? where user_id=? and workflow_id = ?",
          [
            settings.scenarios,
            settings.actions,
            settings.updatedAt,
            settings.autoload,
            settings.userId,
            settings.workflowId
          ]);
      return raw;
    }
  }

  Future<Map<String, dynamic>> autoload(int userId) async {
    final db = await _provider.database;

    var res = await db.query("user_settings", where: "user_id = ? and autoload = 1", whereArgs: [userId]);

    return res.isNotEmpty ? res.first : null;
  }

  Future<Map<String, dynamic>> getByUserAndWorkflow(int userId, workflowId) async {
    final db = await _provider.database;

    var res =
        await db.query("user_settings", where: "user_id = ? and workflow_id = ?", whereArgs: [userId, workflowId]);

    return res.isNotEmpty ? res.first : null;
  }

  Future<Map<String, dynamic>> setDefault(int userId, workflowId) async {
    final db = await _provider.database;

    await db.rawQuery("UPDATE user_settings SET autoload=1 where user_id=? and workflow_id = ?", [userId, workflowId]);

    var res = await db
        .rawQuery("UPDATE user_settings SET autoload=null where user_id=? and workflow_id != ?", [userId, workflowId]);

    return res.isNotEmpty ? res.first : null;
  }
}
