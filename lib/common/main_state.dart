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

import 'package:smart_home_app/models/models.dart';

class MainState {
  Settings _settings;
  String _currentUserToken, _currentServerToken;
  User _currentUser;

  // ignore: unnecessary_getters_setters
  Settings get settings => _settings;
  // ignore: unnecessary_getters_setters
  set settings(Settings settings) => _settings = settings;

  // ignore: unnecessary_getters_setters
  User get currentUser => _currentUser;
  // ignore: unnecessary_getters_setters
  set currentUser(User currentUser) => _currentUser = currentUser;

  // ignore: unnecessary_getters_setters
  String get currentUserToken => _currentUserToken;
  // ignore: unnecessary_getters_setters
  set currentUserToken(String currentUserToken) => _currentUserToken = currentUserToken;

  // ignore: unnecessary_getters_setters
  String get currentServerToken => _currentServerToken;
  // ignore: unnecessary_getters_setters
  set currentServerToken(String currentServerToken) => _currentServerToken = currentServerToken;

  static final MainState _singleton = new MainState._internal();

  static MainState get() => _singleton;

  factory MainState() {
    return _singleton;
  }

  MainState._internal();
}
