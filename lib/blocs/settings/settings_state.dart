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

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_home_app/models/setting.dart';
import 'package:smart_home_app/widgets/check_icon.dart';

abstract class SettingsState extends Equatable {
  SettingsState([List props = const []]) : super(props);
}

class SettingsInitial extends SettingsState {
  @override
  String toString() => 'SettingsInitial';
}

class SettingsLoaded extends SettingsState {
  Settings settings;

  SettingsLoaded(this.settings);

  @override
  String toString() => 'SettingsLoaded';
}

class SettingsLoading extends SettingsState {
  @override
  String toString() => 'SettingsLoading';
}

class SettingsFailure extends SettingsState {
  final String error;

  SettingsFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'SettingsFailure { error: $error }';
}

class SettingsShowSnackbar extends SettingsState {
  final String msg;

  SettingsShowSnackbar(this.msg);

  @override
  String toString() => 'SettingsShowSnackbar';
}

class SettingsValidateAddressValid extends SettingsState {
  final CheckStatus status;

  SettingsValidateAddressValid({@required this.status});

  @override
  String toString() => 'SettingsValidateAddressValid';
}

class SettingsValidateAccessTokenValid extends SettingsState {
  final CheckStatus status;

  SettingsValidateAccessTokenValid({@required this.status});

  @override
  String toString() => 'SettingsValidateAccessTokenValid';
}
