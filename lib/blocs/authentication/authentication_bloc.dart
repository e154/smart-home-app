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
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/repositories/repositories.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:smart_home_app/common/common.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final MainState mainState = new MainState();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      mainState.currentUserToken = event.token;
      mainState.currentUser = event.user;
      Repository.get().stream.connect();
      yield AuthenticationAuthenticated(user: event.user);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      mainState.currentUserToken = "";
      mainState.currentUser = null;
      Repository.get().stream.close();
      yield AuthenticationUnauthenticated();
    }

    if (event is FetchCurrentUser) {
      if (mainState.currentUser != null) {
        yield AuthenticationAuthenticated(user: mainState.currentUser);
      }
    }
  }
}
