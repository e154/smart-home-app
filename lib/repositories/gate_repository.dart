import 'dart:async';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class GateRepository {
  final http.Client httpClient;

  GateRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<bool> checkServerConnection(String baseUrl) async {
    final locationUrl = '$baseUrl/check/mobile_access';
    try {
      final locationResponse = await this.httpClient.get(locationUrl);
      return locationResponse.statusCode == 200 &&
          locationResponse.body == "smart-home-gate";
    } catch (error) {
      return false;
    }
  }

  Future<bool> checkServerToken(String baseUrl, String accessToken) async {
    final locationUrl = '$baseUrl/check/mobile_access_token';
    try {
      final locationResponse = await this
          .httpClient
          .get(locationUrl, headers: {'ServerAuthorization': accessToken});
      return locationResponse.statusCode == 200 &&
          locationResponse.body == "ok";
    } catch (error) {
      return false;
    }
  }
}
