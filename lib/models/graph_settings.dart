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
//     final graphSettings = graphSettingsFromJson(jsonString);

import 'dart:convert';

GraphSettings graphSettingsFromJson(String str) => GraphSettings.fromJson(json.decode(str));

String graphSettingsToJson(GraphSettings data) => json.encode(data.toJson());

class GraphSettings {
  int width;
  int height;
  Position position;

  GraphSettings({
    this.width,
    this.height,
    this.position,
  });

  factory GraphSettings.fromJson(Map<String, dynamic> json) => GraphSettings(
    width: json["width"] as int,
    height: json["height"] as int,
    position: Position.fromJson(json["position"]),
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "position": position.toJson(),
  };
}

class Position {
  int top;
  int left;

  Position({
    this.top,
    this.left,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    top: json["top"] as int,
    left: json["left"] as int,
  );

  Map<String, dynamic> toJson() => {
    "top": top,
    "left": left,
  };
}
