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
//     final telemetryCpu = telemetryCpuFromJson(jsonString);

import 'dart:convert';

TelemetryCpu telemetryCpuFromJson(String str) => TelemetryCpu.fromJson(json.decode(str));

String telemetryCpuToJson(TelemetryCpu data) => json.encode(data.toJson());

class TelemetryCpu {
  double all;

  TelemetryCpu({
    this.all,
  });

  factory TelemetryCpu.fromJson(Map<String, dynamic> json) => TelemetryCpu(
    all: json["all"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}
