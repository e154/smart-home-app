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
import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:smart_home_app/models/models.dart';

import '../constants.dart';

class MapRepository {
  Client httpClient;

  MapRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<List<MapShort>> fetchList(
      int limit, offset, String order, sortBy) async {
    try {
      final mapListResponse = await this
          .httpClient
          .get('/maps?limit=$limit&offset=$offset&order=$order&sort_by=$sortBy')
          .timeout(const Duration(seconds: 1));

      switch (mapListResponse.statusCode) {
        case 200:
          final mapList = (jsonDecode(mapListResponse.body)["items"] as List)
              .map((f) => MapShort.fromJson(f))
              .toList();
          return mapList;
          break;
        default:
          throw Exception('error fetch map list: ' + mapListResponse.body);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<MapFull> getById(int mapId) async {
    try {
      final mapFullResponse = await this
          .httpClient
          .get('/map/$mapId/full')
          .timeout(const Duration(seconds: 1));

      switch (mapFullResponse.statusCode) {
        case 200:
          final mapFull = MapFull.fromJson(jsonDecode(mapFullResponse.body));
          return mapFull;
          break;
        default:
          throw Exception('error fetch map list: ' + mapFullResponse.body);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<MapElement>> getActiveElements(int limit, offset) async {
    try {
      final mapFullResponse = await this
          .httpClient
          .get('/map/active_elements?limit=$limit&offset=$offset')
          .timeout(const Duration(seconds: 3));

      switch (mapFullResponse.statusCode) {
        case 200:
          final mapList = (jsonDecode(mapFullResponse.body)["items"] as List)
              .map((f) => MapElement.fromJson(f)).toList();
          return mapList;
          break;
        default:
          throw Exception('error fetch device list: ' + mapFullResponse.body);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
