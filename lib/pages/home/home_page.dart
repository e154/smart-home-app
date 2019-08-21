import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/authentication/authentication.dart';
import 'package:smart_home_app/pages/main_menu/main_menu.dart';
import 'package:smart_home_app/pages/maps/maps.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Smart home'),
      ),
      body: BlocProvider(
        builder: (context) {
          return MapsBloc();
        },
        child: MapsForm(),
      ),
      drawer: MainMenu(),
    );
  }
}
