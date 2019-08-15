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
    print("update credentials");
    var variable = new Variable();
    variable.name = credentialsName;
    variable.value = jsonEncode(credentials);
    variable.updatedAt = DateTime.now().toIso8601String();
    table.createOrUpdate(variable);
    return credentials;
  }

  // update user credentials database variable
  Future<Credentials> clearCredentials() async {
    print("clear credentials");
    Credentials credentials = new Credentials();
    var variable = new Variable();
    variable.name = credentialsName;
    variable.value = jsonEncode(credentials);
    variable.updatedAt = DateTime.now().toIso8601String();
    table.createOrUpdate(variable);
    return credentials;
  }
}
