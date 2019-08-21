import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/models/setting.dart';
import 'package:smart_home_app/repositories/repositories.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Settings oldSettings;

  SettingsBloc();

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is FetchSettings) {
      yield SettingsLoading();
      Settings settings = await Adaptors.get().variable.getSettings();
      yield SettingsLoaded(settings);
    }
    if (event is UpdateSettings) {
      if (oldSettings != null && oldSettings.equal(event.settings)) {
        return;
      }
      oldSettings = event.settings;
      Adaptors.get().variable.updateSettings(event.settings);

      // check server address
      if (event.settings.serverAddress != "") {
        bool result = await Repository.get().gate
            .checkServerConnection(event.settings.serverAddress);
        yield SettingsValidateAddressValid(status: result);

        // check access token
        if (event.settings.accessToken != "") {
          bool result = await Repository.get().gate.checkServerToken(
              event.settings.serverAddress, event.settings.accessToken);
          yield SettingsValidateAccessTokenValid(status: result);
        }
      }
    }
  }

  Future<Settings> getSettings() => Adaptors.get().variable.getSettings();
}
