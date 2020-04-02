/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home-app
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/blocs/authentication/authentication.dart';
import 'package:smart_home_app/models/setting.dart';
import 'package:smart_home_app/repositories/repositories.dart';
import 'package:smart_home_app/widgets/check_icon.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Settings oldSettings;
  final AuthenticationBloc authenticationBloc;

  SettingsBloc(this.authenticationBloc);

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsFetchSettings) {
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
        yield SettingsValidateAddressValid(status: result ? CheckStatus.ok : CheckStatus.error);

        // check access token
        if (event.settings.accessToken != "") {
          bool result = await Repository.get().gate.checkServerToken(
              event.settings.serverAddress, event.settings.accessToken);
          yield SettingsValidateAccessTokenValid(status: result ? CheckStatus.ok : CheckStatus.error);
        }
      } else {
        authenticationBloc.dispatch(LoggedOut());
      }
    }
  }

  Future<Settings> getSettings() => Adaptors.get().variable.getSettings();
}
