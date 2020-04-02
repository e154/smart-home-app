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
//     final mapOptions = mapOptionsFromJson(jsonString);

import 'dart:convert';

MapOptions mapOptionsFromJson(String str) =>
    MapOptions.fromJson(json.decode(str));

String mapOptionsToJson(MapOptions data) => json.encode(data.toJson());

class MapOptions {
  int zoom;
  bool elementStateText, elementOptionText;

  MapOptions({
    this.zoom,
    this.elementStateText,
    this.elementOptionText,
  });

  factory MapOptions.fromJson(Map<String, dynamic> json) => new MapOptions(
        zoom: json["zoom"],
        elementStateText: json["element_state_text"],
        elementOptionText: json["element_option_text"],
      );

  Map<String, dynamic> toJson() => {
        "zoom": zoom,
        "element_state_text": elementStateText,
        "element_option_text": elementOptionText,
      };
}
