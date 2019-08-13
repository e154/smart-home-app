import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/models/setting.dart';
import 'package:smart_home_app/repository/user_repository.dart';

import 'package:smart_home_app/authentication/authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final Adaptors adaptors;

  AuthenticationBloc({@required this.userRepository, this.adaptors})
      : assert(userRepository != null && adaptors != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();
      final Settings settings = await adaptors.variable.getSettings();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      }

      // goto settings page and set connect params
      if (!settings.validSettings()) {
        yield NeedUpdateSettings();
        return;
      }

      // goto login page
      if (!settings.validLoginParams()) {
        yield AuthenticationUnauthenticated();
      }

//      final bool hasToken = await userRepository.hasToken();

//      if (hasToken) {
//        yield AuthenticationAuthenticated();
//      } else {
//        yield AuthenticationUnauthenticated();
//      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
