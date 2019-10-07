// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);

import 'dart:convert';

Settings settingsFromJson(String str) => Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

class Settings {
  String serverAddress = "";
  String accessToken = "";

  Settings();

  bool get isValid => accessToken != "" && serverAddress != "";

  factory Settings.fromJson(Map<String, dynamic> json) {
    Settings settings = new Settings();
    settings.serverAddress = json["server_address"];
    settings.accessToken = json["access_token"];

    return settings;
  }

  Map<String, dynamic> toJson() => {
        "server_address": serverAddress,
        "access_token": accessToken,
      };

  bool equal(Settings s) {
    return s.serverAddress == serverAddress && s.accessToken == accessToken;
  }
}
