import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'gate_repository.dart';
import 'user_repository.dart';

class Repository {
  GateRepository gate;
  UserRepository user;

  static final Repository _singleton = new Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal() {
    final httpClient = http.Client();
    gate = new GateRepository(httpClient: httpClient);
    user = new UserRepository(httpClient: httpClient);
  }
}
