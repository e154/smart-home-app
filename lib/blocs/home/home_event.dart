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
import 'package:flutter/cupertino.dart';
import 'package:smart_home_app/models/models.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super(props);
}

class HomeFetchSettings extends HomeEvent {
  @override
  String toString() => 'HomeFetchSettings';
}

class HomeFetchWorkflow extends HomeEvent {
  @override
  String toString() => 'HomeFetchWorkflow';
}

class HomeUpdateFavoriteScenarioList extends HomeEvent {
  final List<int> scenarios;

  HomeUpdateFavoriteScenarioList(this.scenarios);

  @override
  String toString() => 'HomeUpdateFavoriteScenarioList';
}

class HomeUpdateFavoriteActionList extends HomeEvent {
  final List<int> actions;

  HomeUpdateFavoriteActionList(this.actions);

  @override
  String toString() => 'HomeUpdateFavoriteActionList';
}

class HomeSelectWorkflow extends HomeEvent {
  WorkflowShort _workflow;

  HomeSelectWorkflow(this._workflow);

  WorkflowShort get workflow => _workflow;

  @override
  String toString() => 'HomeSelectWorkflow';
}

class HomeDoAction extends HomeEvent {
  final MapDeviceAction action;

  HomeDoAction({@required this.action});

  @override
  String toString() => 'HomeDoAction';
}

class HomeSelectScenario extends HomeEvent {
  final int workflowId, scenarioId;

  HomeSelectScenario({@required this.workflowId, this.scenarioId});

  @override
  String toString() => 'HomeSelectScenario';
}
