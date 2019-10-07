import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage();

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

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
          return SettingsBloc(authenticationBloc);
        },
        child: SettingsForm(),
      ),
    );
  }
}
