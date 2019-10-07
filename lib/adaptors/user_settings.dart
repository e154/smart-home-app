import 'dart:convert';

import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/db/db.dart';
import 'package:smart_home_app/models/models.dart' as models;

class UserSettingsAdaptor {
  UserSettings table;

  UserSettingsAdaptor(DBProvider _provider) {
    table = new UserSettings(_provider);
  }


  //  return saved settings or create empty object
  Future<models.UserSettings> autoload(int userId) async {
    models.UserSettings userSettings;

    Map<String, dynamic> res = await table.autoload(userId);
    if (res == null || res.isEmpty) {
      return null;
    } else {
      final dbUserSettings = UserSetting.fromJson(res);
      userSettings = _fromDb(dbUserSettings);
    }
    return userSettings;
  }

  // select workflow
  Future<void> setWorkflow(int userId, workflowId) async {
    Map<String, dynamic> res = await table.getByUserAndWorkflow(userId, workflowId);

    if (res == null || res.isEmpty) {
      // user settings not found
      // create new
      var variable = new UserSetting();
      variable.userId = userId;
      variable.workflowId = workflowId;
      variable.scenarios = "[]";
      variable.actions = "[]";
      variable.autoload = 1;
      variable.createdAt = DateTime.now().toIso8601String();
      await table.createOrUpdate(variable);
    }

    // select as default
    await table.setDefault(userId, workflowId);
  }

  // update user settings
  Future<void> update(models.UserSettings userSettings) async {
    var dbUserSettings = _toDb(userSettings);
    table.createOrUpdate(dbUserSettings);
  }

  models.UserSettings _fromDb(UserSetting dbUserSettings) {
    final userSettings = new models.UserSettings(
      id: dbUserSettings.id,
      userId: dbUserSettings.userId,
      workflowId: dbUserSettings.workflowId,
      autoload: dbUserSettings.autoload,
      scenarios: dbUserSettings.scenarios == null ? null : (jsonDecode(dbUserSettings.scenarios) as List).map((f) =>
      f as int).toList(),
      actions: dbUserSettings.actions == null ? null : (jsonDecode(dbUserSettings.actions) as List).map((f) =>
      f as int).toList(),
      createdAt: dbUserSettings.createdAt == null ? null : DateTime.parse(ignoreSubMicro(dbUserSettings.createdAt)),
      updatedAt: dbUserSettings.updatedAt == null ? null : DateTime.parse(ignoreSubMicro(dbUserSettings.updatedAt)),
    );
    return userSettings;
  }

  UserSetting _toDb(models.UserSettings userSettings) {
    final dbUserSettings = new UserSetting();
    dbUserSettings.id = userSettings.id;
    dbUserSettings.userId = userSettings.userId;
    dbUserSettings.workflowId = userSettings.workflowId;
    dbUserSettings.scenarios = jsonEncode(userSettings.scenarios);
    dbUserSettings.actions = jsonEncode(userSettings.actions);
    dbUserSettings.autoload = userSettings.autoload;
    dbUserSettings.updatedAt = DateTime.now().toIso8601String();
    return dbUserSettings;
  }
}
