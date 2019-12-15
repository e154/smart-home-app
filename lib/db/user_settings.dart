import 'dart:convert';

import 'db.dart';

class UserSetting {
  int id, userId, workflowId, autoload;
  String serverAddress, scenarios, actions, createdAt, updatedAt;

  factory UserSetting.fromRawJson(String str) => UserSetting.fromJson(json.decode(str));

  UserSetting({
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

  String toRawJson() => json.encode(toJson());

  factory UserSetting.fromJson(Map<String, dynamic> json) => new UserSetting(
        id: json["id"] as int,
        userId: json["user_id"] as int,
        workflowId: json["workflow_id"] == null ? null : json["workflow_id"] as int,
        autoload: json["autoload"] == null ? null : json["autoload"] as int,
        scenarios: json["scenarios"],
        actions: json["actions"],
        serverAddress: json["server_address"],
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
        "server_address": serverAddress,
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
        where: "user_id = ? and workflow_id = ? and server_address = ?", whereArgs: [settings.userId, settings.workflowId, settings.serverAddress]);

    if (res.isEmpty) {
      var raw = await db.rawInsert(
          "INSERT Into user_settings (user_id, workflow_id, scenarios, "
          "actions, autoload, server_address, created_at)  VALUES (?,?,?,?,?,?,?)",
          [
            settings.userId,
            settings.workflowId,
            settings.scenarios,
            settings.actions,
            settings.autoload,
            settings.serverAddress,
            settings.createdAt,
          ]);
      return raw;
    } else {
      var raw = await db.rawInsert(
          "UPDATE user_settings SET scenarios=?, actions=?,"
          " updated_at=?, autoload=? where user_id=? and workflow_id=? and server_address=?",
          [
            settings.scenarios,
            settings.actions,
            settings.updatedAt,
            settings.autoload,
            settings.userId,
            settings.workflowId,
            settings.serverAddress
          ]);
      return raw;
    }
  }

  Future<Map<String, dynamic>> autoload(int userId, String serverAddress) async {
    final db = await _provider.database;

    var res = await db.query("user_settings", where: "user_id = ? and autoload = 1 and server_address = ?", whereArgs: [userId, serverAddress]);

    return res.isNotEmpty ? res.first : null;
  }

  Future<Map<String, dynamic>> getByUserAndWorkflow(int userId, workflowId, String serverAddress) async {
    final db = await _provider.database;

    var res =
        await db.query("user_settings", where: "user_id = ? and workflow_id = ? and server_address = ?", whereArgs: [userId, workflowId, serverAddress]);

    return res.isNotEmpty ? res.first : null;
  }

  Future<Map<String, dynamic>> setDefault(int userId, workflowId, String serverAddress) async {
    final db = await _provider.database;

    await db.rawQuery("UPDATE user_settings SET autoload=1 where user_id=? and workflow_id = ? and server_address = ?", [userId, workflowId, serverAddress]);

    var res = await db
        .rawQuery("UPDATE user_settings SET autoload=null where user_id=? and workflow_id != ? and server_address = ?", [userId, workflowId, serverAddress]);

    return res.isNotEmpty ? res.first : null;
  }
}
