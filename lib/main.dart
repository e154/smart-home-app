import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/pages/about/about.dart';
import 'package:smart_home_app/pages/settings/settings.dart';
import 'package:smart_home_app/authentication/authentication.dart';
import 'package:smart_home_app/pages/splash/splash.dart';
import 'package:smart_home_app/pages/login/login.dart';
import 'package:smart_home_app/pages/home/home.dart';
import 'package:smart_home_app/common/common.dart';
import 'package:http/http.dart' as http;

import 'adaptors/adaptors.dart';
import 'repositories/repositories.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

Future main() async {
  Adaptors adaptors = new Adaptors();
  Repository repository = new Repository();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (context) {
            return AuthenticationBloc(
                repository: repository, adaptors: adaptors)
              ..dispatch(AppStarted());
          },
        ),
        BlocProvider<SettingsBloc>(
          builder: (context) =>
//              SettingsBloc(),
              SettingsBloc(),
        ),
      ],
      child: App(
        repository: repository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final Repository repository;
  final Adaptors adaptors;

  App({Key key, @required this.repository, @required this.adaptors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(repository: repository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
      routes: <String, WidgetBuilder>{
        '/settings': (BuildContext context) => SettingsPage(),
        '/about': (BuildContext context) => AboutPage(),
      },
    );
  }
}
