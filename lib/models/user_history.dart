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
//     final userHistory = userHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

UserHistory userHistoryFromJson(String str) =>
    UserHistory.fromJson(json.decode(str));

String userHistoryToJson(UserHistory data) => json.encode(data.toJson());

class UserHistory {
  String ip;
  DateTime time;

  UserHistory({
    this.ip,
    this.time,
  });

  factory UserHistory.fromJson(Map<String, dynamic> json) => new UserHistory(
        ip: json["ip"],
        time: DateTime.parse(ignoreSubMicro(json["time"])),
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "time": time,
      };
}
