import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/pages/main_menu/main_menu.dart';

import 'package:smart_home_app/authentication/authentication.dart';
import 'package:smart_home_app/repositories/repositories.dart';

import 'maps_bloc.dart';
import 'maps_form.dart';

class MapsPage extends StatelessWidget {
  final Repository repository;

  MapsPage({Key key, @required this.repository})
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
          return MapsBloc(
//            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
//            repository: repository,
          );
        },
        child: MapsForm(),
      ),
      drawer: MainMenu(),
    );
  }
}
