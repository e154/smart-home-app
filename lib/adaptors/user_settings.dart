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
  Future<models.UserSettings> autoload(int userId, String serverAddress) async {
    models.UserSettings userSettings;

    Map<String, dynamic> res = await table.autoload(userId, serverAddress);
    if (res == null || res.isEmpty) {
      return null;
    } else {
      final dbUserSettings = UserSetting.fromJson(res);
      userSettings = _fromDb(dbUserSettings);
    }
    return userSettings;
  }

  // select workflow
  Future<void> setWorkflow(int userId, workflowId, String serverAddress) async {
    Map<String, dynamic> res = await table.getByUserAndWorkflow(userId, workflowId, serverAddress);

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
      variable.serverAddress = serverAddress;
      await table.createOrUpdate(variable);
    }

    // select as default
    await table.setDefault(userId, workflowId, serverAddress);
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
      serverAddress: dbUserSettings.serverAddress,
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
    dbUserSettings.serverAddress = userSettings.serverAddress;
    dbUserSettings.updatedAt = DateTime.now().toIso8601String();
    return dbUserSettings;
  }
}
