import 'dart:async';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/models/setting.dart';
import 'package:smart_home_app/widgets/widgets.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm() {}

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _serverAddress = TextEditingController();
  final _accessToken = TextEditingController();
  Timer _debounce;
  CheckStatus _serverAddressValid;
  CheckStatus _accessTokenValid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    settingsBloc.dispatch(SettingsFetchSettings());

    void _updateSettings() {
      Settings settings = new Settings();
      settings.serverAddress = _serverAddress.text;
      settings.accessToken = _accessToken.text;
      settingsBloc.dispatch(UpdateSettings(settings));
    }

    Future scan() async {
      try {
        String barcode = await BarcodeScanner.scan();
        this._accessToken.text = barcode;
        _updateSettings();
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

    void _sendUpdateSettingsEvent() {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _updateSettings();
      });
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
        if (state is SettingsShowSnackbar) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.msg}'),
              backgroundColor: Colors.green,
            ),
          );
        }
        if (state is SettingsValidateAddressValid) {
          _serverAddressValid = state.status;
        }
        if (state is SettingsValidateAccessTokenValid) {
          _accessTokenValid = state.status;
        }
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            _serverAddress.text = state.settings.serverAddress;
            _accessToken.text = state.settings.accessToken;
          }

          return Form(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                    labelText: 'server address',
                    suffixIcon: CheckIconWidget(_serverAddressValid),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        top: 20.0, right: 30.0, bottom: 10.0, left: 10.0),
                  ),
                  controller: _serverAddress,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                    labelText: 'access token',
                    suffixIcon: CheckIconWidget(_accessTokenValid),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        top: 10.0, right: 30.0, bottom: 10.0, left: 10.0),
                  ),
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

  @override
  void dispose() {
    _serverAddress.dispose();
    _accessToken.dispose();
    super.dispose();
  }
}
