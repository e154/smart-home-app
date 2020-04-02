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

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class HomeInitial extends HomeState {
  @override
  String toString() => 'HomeInitial';
}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'HomeFailure { error: $error }';
}

class HomeLoading extends HomeState {
  @override
  String toString() => 'HomeLoading';
}

class HomeLoaded extends HomeState {
  UserSettings _userSettings;
  Workflow _workflow;
  List<MapElement> _deviceList;

  HomeLoaded(this._userSettings, this._workflow, this._deviceList);

  Workflow get workflow => _workflow;

  UserSettings get userSettings => _userSettings;

  List<MapElement> get deviceList => _deviceList;

  @override
  String toString() => 'HomeLoaded';
}

class HomeLoadedScenarios extends HomeState {
  List<WorkflowScenario> scenarios;

  HomeLoadedScenarios(this.scenarios);

  @override
  String toString() => 'HomeLoadedScenarios';
}
