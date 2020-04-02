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
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/blocs/authentication/authentication.dart';
import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';

import 'package:smart_home_app/repositories/repositories.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationBloc,
  }) : assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginFetchSettings) {
      yield LoginLoadSettings();
      Settings settings = await Adaptors.get().variable.getSettings();
      Credentials credentials = await Adaptors.get().variable.getCredentials();
      yield LoginSettingsLoaded(settings, credentials);
    }
    if (event is LoginButtonPressed) {
      try {
        yield LoginLoading();
        Settings settings = await Adaptors.get().variable.getSettings();
        MainState.get().settings = settings;

        //save user credentials
        Credentials credentials = new Credentials();
        credentials.userLogin = event.username;
        credentials.userPassword = event.password;
        await Adaptors.get().variable.updateCredentials(credentials);

        dynamic response = await Repository.get()
            .auth
            .signin(settings: settings, credentials: credentials);

        String token = response["access_token"];
        User currentUser = User.fromJson(response["current_user"]);

        authenticationBloc.dispatch(LoggedIn(token: token, user: currentUser));

        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
