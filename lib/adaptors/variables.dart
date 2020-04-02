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

import 'package:smart_home_app/db/db.dart';
import 'package:smart_home_app/db/variable.dart';
import 'package:smart_home_app/models/credentials.dart';
import 'package:smart_home_app/models/setting.dart';

class VariableAdaptor {
  final String settingsName = "SETTINGS";
  final String credentialsName = "CREDENTIALS";

  Variables table;

  VariableAdaptor(DBProvider _provider) {
    table = new Variables(_provider);
  }

  //  return saved settings or create empty object
  Future<Settings> getSettings() async {
    Settings settings;
    Map<String, dynamic> variable = await table.get(settingsName);
    if (variable == null || variable.isEmpty) {
      settings = Settings();
      settings.serverAddress = "https://gate.e154.ru";
      var variable = new Variable();
      variable.name = settingsName;
      variable.value = jsonEncode(settings);
      variable.autoload = 1;
      variable.createdAt = DateTime.now().toIso8601String();
      table.createOrUpdate(variable);
    } else {
      Map<String, dynamic> settingsJson = jsonDecode(variable["value"]);
      settings = Settings.fromJson(settingsJson);
    }
    return settings;
  }

  // update settings database variable
  Future<Settings> updateSettings(Settings settings) async {
    var variable = new Variable();
    variable.name = settingsName;
    variable.value = jsonEncode(settings);
    variable.updatedAt = DateTime.now().toIso8601String();
    table.createOrUpdate(variable);
    return settings;
  }

  //  return user credentials or create empty object
  Future<Credentials> getCredentials() async {
    Credentials credentials;
    Map<String, dynamic> variable = await table.get(credentialsName);
    if (variable == null || variable.isEmpty) {
      credentials = Credentials();
      var variable = new Variable();
      variable.name = credentialsName;
      variable.value = jsonEncode(credentials);
      variable.autoload = 1;
      variable.createdAt = DateTime.now().toIso8601String();
      table.createOrUpdate(variable);
    } else {
      Map<String, dynamic> credentialsJson = jsonDecode(variable["value"]);
      credentials = Credentials.fromJson(credentialsJson);
    }
    return credentials;
  }

  // update user credentials database variable
  Future<Credentials> updateCredentials(Credentials credentials) async {
    var variable = new Variable();
    variable.name = credentialsName;
    variable.value = jsonEncode(credentials);
    variable.updatedAt = DateTime.now().toIso8601String();
    table.createOrUpdate(variable);
    return credentials;
  }

  // update user credentials database variable
  Future<Credentials> clearCredentials() async {
    Credentials credentials = new Credentials();
    var variable = new Variable();
    variable.name = credentialsName;
    variable.value = jsonEncode(credentials);
    variable.updatedAt = DateTime.now().toIso8601String();
    table.createOrUpdate(variable);
    return credentials;
  }
}
