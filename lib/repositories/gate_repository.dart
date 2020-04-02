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

import 'dart:async';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class GateRepository {
  final http.Client httpClient;

  GateRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<bool> checkServerConnection(String baseUrl) async {
    final locationUrl = '$baseUrl/check/mobile_access';
    try {
      final locationResponse = await this
          .httpClient
          .get(locationUrl)
          .timeout(const Duration(seconds: 1));
      return locationResponse.statusCode == 200 &&
          locationResponse.body == "smart-home-gate";
    } catch (error) {
      return false;
    }
  }

  Future<bool> checkServerToken(String baseUrl, String accessToken) async {
    final locationUrl = '$baseUrl/check/mobile_access_token';
    try {
      final locationResponse = await this.httpClient.get(locationUrl, headers: {
        'ServerAuthorization': accessToken
      }).timeout(const Duration(seconds: 1));
      return locationResponse.statusCode == 200 &&
          locationResponse.body == "ok";
    } catch (error) {
      return false;
    }
  }
}
