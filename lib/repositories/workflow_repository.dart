import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:smart_home_app/models/models.dart';

class WorkflowRepository {
  Client httpClient;

  WorkflowRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Workflow>> fetchList(int limit, offset, String order, sortBy) async {
    try {
      final mapListResponse = await this
          .httpClient
          .get('/workflows?limit=$limit&offset=$offset&order=$order&sort_by=$sortBy')
          .timeout(const Duration(seconds: 1));

      switch (mapListResponse.statusCode) {
        case 200:
          final mapList = (jsonDecode(mapListResponse.body)["items"] as List)
              .map((f) => Workflow.fromJson(f))
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


}
