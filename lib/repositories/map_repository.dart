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
}
