/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home-app
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:smart_home_app/repositories/server_stream/server_stream.dart';

import 'auth_repository.dart';
import 'gate_repository.dart';
import 'server_interceptor.dart';
import 'map_repository.dart';
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
