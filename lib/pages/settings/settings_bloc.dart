import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/models/setting.dart';
import 'package:smart_home_app/repositories/repositories.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Adaptors adaptors;
  Repository repository;

  SettingsBloc() {
    adaptors = new Adaptors();
    repository = new Repository();
  }

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is FetchSettings) {
      yield SettingsLoading();
      Settings settings = await adaptors.variable.getSettings();
      yield SettingsLoaded(settings);
    }
    if (event is UpdateSettings) {
      adaptors.variable.updateSettings(event.settings);
      if (event.settings.serverAddress != "") {
        bool result = await repository.gate.checkServerConnection(event.settings.serverAddress);
        print('result: $result');
      }

    }
  }

  Future<Settings> getSettings() => adaptors.variable.getSettings();
}
