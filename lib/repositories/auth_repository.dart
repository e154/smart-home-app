import 'dart:async';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:smart_home_app/models/models.dart';
import 'dart:convert';

class AuthRepository {
  final http.Client httpClient;

  AuthRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<dynamic> signin(
      {@required Settings settings,
      @required Credentials credentials}) async {

    final signInResponse = await this.httpClient.post('/signin', headers: {
      'Authorization': credentials.basicAuth(),
    }).timeout(const Duration(seconds: 5));

    if (signInResponse.statusCode != 200) {
      throw Exception('error authenticate ' + signInResponse.body);
    }

    return jsonDecode(signInResponse.body);
  }

  Future<void> accessList() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> recovery() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> reset() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> signout() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }
}
