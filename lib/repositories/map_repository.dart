import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';

import '../constants.dart';

class MapRepository {
  Client httpClient;

  MapRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<List<MapShort>> fetchList() async {
    try {
      Settings settings = await Adaptors.get().variable.getSettings();
      final locationUrl = settings.serverAddress +
          BASE_PATH +
          '/maps?limit=10&offset=0&order=DESC&sort_by=id';
      final mapListResponse = await this.httpClient.get(locationUrl, headers: {
        'Authorization': MainState.get().currentUserToken,
        'ServerAuthorization': settings.accessToken,
        'Content-Type': 'application/json'
      }).timeout(const Duration(seconds: 1));

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
      Settings settings = await Adaptors.get().variable.getSettings();
      final locationUrl = settings.serverAddress + '$BASE_PATH/map/$mapId/full';
      final mapFullResponse = await this.httpClient.get(locationUrl, headers: {
        'Authorization': MainState.get().currentUserToken,
        'ServerAuthorization': settings.accessToken,
        'Content-Type': 'application/json'
      }).timeout(const Duration(seconds: 1));

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
