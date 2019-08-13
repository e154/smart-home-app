import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_bloc.dart';
import 'settings_state.dart';
import 'package:flutter/services.dart';

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

    _onSettingsScanQrCode() {
      scan();
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
                ),
                RaisedButton(
                  onPressed: _onSettingsScanQrCode,
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
}
