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

  Future<bool> checkServerConnection(String baseUrl) async {
    final locationUrl = '$baseUrl/';
    try {
      final locationResponse = await this.httpClient.get(locationUrl);
      return locationResponse.statusCode == 200;
    } catch (error) {
//      print(error);
      return false;
    }
  }

  Future<void> checkServerToken() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }
}
