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
//     final credentials = credentialsFromJson(jsonString);

import 'dart:convert';

Credentials credentialsFromJson(String str) =>
    Credentials.fromJson(json.decode(str));

String credentialsToJson(Credentials data) => json.encode(data.toJson());

class Credentials {
  String userLogin = "";
  String userPassword = "";

  Credentials();

  bool get isValid => userLogin != "" && userPassword != "";

  factory Credentials.fromJson(Map<String, dynamic> json) {
    Credentials credentials = new Credentials();
    credentials.userLogin = json["user_login"];
    credentials.userPassword = json["user_password"];

    return credentials;
  }

  Map<String, dynamic> toJson() => {
        "user_login": userLogin,
        "user_password": userPassword,
      };

  bool equal(Credentials s) {
    return s.userPassword == userPassword && s.userLogin == userLogin;
  }

  String basicAuth() {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userLogin:$userPassword'));
    return basicAuth;
  }
}
