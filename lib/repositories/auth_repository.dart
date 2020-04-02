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
    }).timeout(const Duration(seconds: 60));

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
