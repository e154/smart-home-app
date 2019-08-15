import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/repository/user_repository.dart';

import 'package:smart_home_app/authentication/authentication.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  Adaptors _adaptors;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
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
          final token = await userRepository.authenticate(
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
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
        //save user credentials
        Credentials credentials = new Credentials();
        credentials.userLogin = event.username;
        credentials.userPassword = event.password;
        await _adaptors.variable.updateCredentials(credentials);
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
