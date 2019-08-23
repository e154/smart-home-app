import 'dart:async';
import 'package:bloc/bloc.dart';
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
      yield AuthenticationAuthenticated(user: event.user);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      mainState.currentUserToken = "";
      mainState.currentUser = null;
      yield AuthenticationUnauthenticated();
    }

    if (event is FetchCurrentUser) {
      if (mainState.currentUser != null) {
        yield AuthenticationAuthenticated(user: mainState.currentUser);
      }
    }
  }
}
