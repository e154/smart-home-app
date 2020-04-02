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
//     final serverImage = serverImageFromJson(jsonString);

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/common/main_state.dart';

import '../constants.dart';

ServerImage serverImageFromJson(String str) =>
    ServerImage.fromJson(json.decode(str));

String serverImageToJson(ServerImage data) => json.encode(data.toJson());

class ServerImage {
  int id;
  String url, _baseUrl;

  ServerImage(
    this.id,
    this.url,
  ) : assert(url != null) {
    _baseUrl = MainState.get().settings.serverAddress +
        '/server' +
        url +
        '?server_access_token=' +
        MainState.get().settings.accessToken;
  }

  factory ServerImage.fromJson(Map<String, dynamic> json) {
    return ServerImage(
      json["id"] as int,
      json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };

  Widget get image {
    if (_baseUrl.contains('.svg')) {
      return getSvgImage();
    } else {
      return getOtherImage();
    }
  }

  getOtherImage() {
    return Image.network(
      _baseUrl,
      alignment: Alignment.topLeft,
    );
  }

  getSvgImage() {
    return SvgPicture.network(
      _baseUrl,
      alignment: Alignment.topLeft,
    );
  }
}
