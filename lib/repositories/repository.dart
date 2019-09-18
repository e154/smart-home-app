import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'auth_repository.dart';
import 'gate_repository.dart';
import 'server_interceptor.dart';
import 'map_repository.dart';
import 'server_stream.dart';
import 'user_repository.dart';
import 'workflow_repository.dart';

class Repository {
  GateRepository gate;
  UserRepository user;
  AuthRepository auth;
  MapRepository map;
  WorkflowRepository workflow;
  ServerStream stream;

  static final Repository _singleton = new Repository._internal();

  static Repository get() => _singleton;

  factory Repository() {
    return _singleton;
  }

  Repository._internal() {
    final httpClient = http.Client();

    final httpClientWithInterceptor =
        HttpClientWithInterceptor.build(interceptors: [
      ServerInterceptor(),
    ]);

    gate = new GateRepository(httpClient: httpClient);
    auth = new AuthRepository(httpClient: httpClientWithInterceptor);
    user = new UserRepository(httpClient: httpClient);
    map = new MapRepository(httpClient: httpClientWithInterceptor);
    workflow = new WorkflowRepository(httpClient: httpClientWithInterceptor);
    stream = new ServerStream();
  }
}
