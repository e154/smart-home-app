import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/pages/main_menu/main_menu.dart';

import 'package:smart_home_app/authentication/authentication.dart';
import 'package:smart_home_app/repositories/repositories.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {
  final Repository repository;

  LoginPage({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            repository: repository,
          );
        },
        child: LoginForm(),
      ),
      drawer: MainMenu(),
    );
  }
}
