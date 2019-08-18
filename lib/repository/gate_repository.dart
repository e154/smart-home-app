import 'dart:async';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class GateRepository {
  final http.Client httpClient;

  GateRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<String> authenticate({
    @required String token,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<String> checkServerAddress(String baseUrl) async {
    final locationUrl = '$baseUrl/';
    final locationResponse = await this.httpClient.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw "error";
    }

    return "ok";
  }

  Future<void> checkServerToken() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }
}
