import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/models/setting.dart';
import 'package:smart_home_app/pages/settings/settings.dart';
import 'settings_bloc.dart';
import 'settings_state.dart';
import 'package:flutter/services.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm() {}

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _serverAddress = TextEditingController();
  final _accessToken = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(context.toString());
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    settingsBloc.dispatch(FetchSettings());

    //TODO to many requests per second, need add timeout 1second
    void _sendUpdateSettingsEvent() {
      Settings settings = new Settings();
      settings.serverAddress = _serverAddress.text;
      settings.accessToken = _accessToken.text;
      settingsBloc.dispatch(UpdateSettings(settings));
    }

    _serverAddress.addListener(() => _sendUpdateSettingsEvent());
    _accessToken.addListener(() => _sendUpdateSettingsEvent());

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

          if (state is SettingsLoaded) {
            _serverAddress.text = state.settings.serverAddress;
            _accessToken.text = state.settings.accessToken;
          }

          return Form(
            child: state is SettingsLoading
              ? CircularProgressIndicator()
              : Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'server address'),
                  controller: _serverAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'access token'),
                  controller: _accessToken,
                ),
                RaisedButton(
                  onPressed: scan,
                  child: Text('SCAN QR CODE'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._accessToken.text = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._accessToken.text =
              'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this._accessToken.text = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this._accessToken.text =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this._accessToken.text = 'Unknown error: $e');
    }
  }

  @override
  void dispose() {
    _serverAddress.dispose();
    _accessToken.dispose();
    super.dispose();
  }
}
