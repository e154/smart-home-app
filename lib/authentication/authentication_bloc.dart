import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';

import 'package:smart_home_app/authentication/authentication.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/repositories/repositories.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository repository;
  final Adaptors adaptors;
  String _accessToken;
  User _currentUser;

  AuthenticationBloc({@required this.repository, this.adaptors})
      : assert(repository != null && adaptors != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await repository.user.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      _accessToken = event.token;
      _currentUser = event.user;
      yield AuthenticationLoading();
      await repository.user.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
//      await adaptors.variable.clearCredentials();
//      await repository.user.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
