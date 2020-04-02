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
