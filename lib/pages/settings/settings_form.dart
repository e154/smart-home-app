import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_bloc.dart';
import 'settings_state.dart';

class SettingsForm extends StatefulWidget {
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _serverAddress = TextEditingController();
  final _accessToken = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    _onSettingsButtonPressed() {
//      settingsBloc.dispatch(SettingsButtonPressed(
//        username: _serverAddress.text,
//        password: _accessToken.text,
//      ));
    }

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'server address'),
                  controller: _serverAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'access token'),
                  controller: _accessToken,
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed: () {
//                  state is! SettingsLoading ? _onSettingsButtonPressed : null,
                  },
                  child: Text('SCAN QR CODE'),
                ),
                Container(
                  child: state is SettingsLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
