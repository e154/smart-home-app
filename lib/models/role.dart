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
//     final role = roleFromJson(jsonString);

import 'dart:convert';

Role roleFromJson(String str) => Role.fromJson(json.decode(str));

String roleToJson(Role data) => json.encode(data.toJson());

class Role {
  String name;
  Map<String, List<String>> accessList;
  String description;

  Role();

  factory Role.fromJson(Map<String, dynamic> json) {
    Role role = new Role();
    role.name = json["name"];
//    role.accessList = json["access_list"] != null ? (json["access_list"] as List).map((f)=> ...);
    role.description = json["description"];

    return role;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "access_list": accessList,
        "description": description,
      };
}
