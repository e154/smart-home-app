import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/pages/main_menu/main_menu.dart';
import 'settings_bloc.dart';
import 'settings_form.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
      body: BlocProvider(
        builder: (context) {
          return SettingsBloc(
//            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
//            userRepository: userRepository,
          );
        },
        child: SettingsForm(),
      ),
      drawer: MainMenu(),
    );
  }
}
