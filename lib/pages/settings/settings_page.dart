import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/repositories/repositories.dart';
import 'settings.dart';
import 'settings_bloc.dart';
import 'settings_form.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Settings'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: BlocProvider(
        builder: (context) {
          return SettingsBloc();
        },
        child: SettingsForm(),
      ),
    );
  }
}
