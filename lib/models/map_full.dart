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
//     final mapFull = mapFullFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

import 'models.dart';

MapFull mapFullFromJson(String str) => MapFull.fromJson(json.decode(str));

String mapFullToJson(MapFull data) => json.encode(data.toJson());

class MapFull {
  int id;
  String name, description;
  DateTime createdAt, updatedAt;

  MapFull({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MapFull.fromJson(Map<String, dynamic> json) => new MapFull(
    id: json["id"] as int,
    name: json["name"] as String,
    description: json["description"] as String,
    createdAt: DateTime.parse(ignoreSubMicro(json["created_at"])),
    updatedAt: DateTime.parse(ignoreSubMicro(json["updated_at"])),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
