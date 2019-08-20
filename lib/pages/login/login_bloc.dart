import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/models/models.dart';

import 'package:smart_home_app/authentication/authentication.dart';
import 'package:smart_home_app/models/user_history.dart';
import 'package:smart_home_app/repositories/repositories.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  final AuthenticationBloc authenticationBloc;
  Adaptors _adaptors;

  LoginBloc({
    @required this.repository,
    @required this.authenticationBloc,
  })  : assert(repository != null),
        assert(authenticationBloc != null) {
    _adaptors = new Adaptors();
  }

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchSettings) {
      yield LoginLoadSettings();
      Settings settings = await _adaptors.variable.getSettings();
      Credentials credentials = await _adaptors.variable.getCredentials();
      yield LoginSettingsLoaded(settings, credentials);
      if (settings.isValid && credentials.isValid) {
        try {
          // auto login, if all params exist
          final token = await repository.user.authenticate(
            username: credentials.userLogin,
            password: credentials.userPassword,
          );

          authenticationBloc.dispatch(LoggedIn(token: token));
          yield LoginInitial();
        } catch (error) {
          yield LoginFailure(error: error.toString());
        }
      }
    }
    if (event is LoginButtonPressed) {
      try {
        Settings settings = await _adaptors.variable.getSettings();

        //save user credentials
        Credentials credentials = new Credentials();
        credentials.userLogin = event.username;
        credentials.userPassword = event.password;
        await _adaptors.variable.updateCredentials(credentials);

        dynamic response = await repository.auth
            .signin(settings: settings, credentials: credentials);

        String token = response["access_token"];
        User user = User.fromJson(response["current_user"]);

        print(response["current_user"]["history"] as List);

        authenticationBloc.dispatch(LoggedIn(token: token));

        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
