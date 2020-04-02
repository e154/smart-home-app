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
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/common/main_state.dart';
import 'package:smart_home_app/models/models.dart';

import '../constants.dart';

class ServerInterceptor implements InterceptorContract {
  final MainState mainState = new MainState();

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    Settings settings = MainState.get().settings;

    data.url = settings.serverAddress + BASE_PATH + data.url;

    if (data.headers["Authorization"] == null) {
      data.headers["Authorization"] = MainState.get().currentUserToken;
    }

    if (data.headers["ServerAuthorization"] == null) {
      data.headers["ServerAuthorization"] = settings.accessToken;
    }

    if (data.headers["Content-Type"] == null) {
      data.headers["Content-Type"] = "application/json";
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }
}
