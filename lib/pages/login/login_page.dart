import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/pages/main_menu/main_menu.dart';

import 'package:smart_home_app/authentication/authentication.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {

  LoginPage({Key key}): super(key: key);

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
          );
        },
        child: LoginForm(),
      ),
      drawer: MainMenu(),
    );
  }
}
