import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'auth_repository.dart';
import 'gate_repository.dart';
import 'interceptor.dart';
import 'map_repository.dart';
import 'user_repository.dart';

class Repository {
  GateRepository gate;
  UserRepository user;
  AuthRepository auth;
  MapRepository map;

  static final Repository _singleton = new Repository._internal();

  static Repository get() => _singleton;

  factory Repository() {
    return _singleton;
  }

  Repository._internal() {
    final httpClient = http.Client();

    final httpClientWithInterceptor =
        HttpClientWithInterceptor.build(interceptors: [
      Interceptor(),
    ]);

    gate = new GateRepository(httpClient: httpClient);
    auth = new AuthRepository(httpClient: httpClientWithInterceptor);
    user = new UserRepository(httpClient: httpClientWithInterceptor);
    map = new MapRepository(httpClient: httpClientWithInterceptor);
  }
}
