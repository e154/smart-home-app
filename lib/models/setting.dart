// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);

import 'dart:convert';

Settings settingsFromJson(String str) => Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

class Settings {
  String serverAddress = "";
  String accessToken = "";
  String userLogin = "";
  String userPassword = "";

  Settings();

  bool validSettings() {
    return accessToken != "" && serverAddress != "";
  }

  bool validLoginParams() {
    return userLogin != "" && userPassword != "";
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    Settings settings = new Settings();
    settings.serverAddress = json["server_address"];
    settings.accessToken = json["access_token"];
    settings.userLogin = json["user_login"];
    settings.userPassword = json["user_password"];

    return settings;
  }

  Map<String, dynamic> toJson() => {
        "server_address": serverAddress,
        "access_token": accessToken,
        "user_login": userLogin,
        "user_password": userPassword,
      };
}
