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

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/pages/pages.dart';
import 'package:smart_home_app/widgets/widgets.dart';

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
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (context) {
            return AuthenticationBloc()..dispatch(AppStarted());
          },
        ),
        BlocProvider<SettingsBloc>(builder: (context) {
          final authenticationBloc =
              BlocProvider.of<AuthenticationBloc>(context);
          return SettingsBloc(authenticationBloc);
        }),
        BlocProvider<MapsBloc>(builder: (context) {
          return MapsBloc();
        }),
        BlocProvider<WorkflowsBloc>(builder: (context) {
          return WorkflowsBloc();
        }),
        BlocProvider<LoginBloc>(builder: (context) {
          final authenticationBloc =
              BlocProvider.of<AuthenticationBloc>(context);
          return LoginBloc(authenticationBloc: authenticationBloc);
        }),
        BlocProvider<HomeBloc>(builder: (context) {
          return HomeBloc();
        }),
        BlocProvider<TabBloc>(builder: (context) {
          return TabBloc();
        }),
        BlocProvider<StreamBloc>(builder: (context) {
          return StreamBloc();
        }),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage();
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
