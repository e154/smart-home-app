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

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/repositories/repository.dart';
import 'package:smart_home_app/repositories/server_stream/response.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc();

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeFetchSettings) {
      yield HomeLoading();

      // get current user
      final currentUser = MainState.get().currentUser;
      // get current settings
      final settings = MainState.get().settings;
      // get here user settings
      final userSettings =
          await Adaptors.get().userSettings.autoload(currentUser.id, settings.serverAddress);

      if (userSettings == null) {
        yield HomeLoaded(userSettings, null, null);
        return;
      }

      final workflow =
          await Repository.get().workflow.getById(userSettings.workflowId);

      final deviceList = await Repository.get().map.getActiveElements(999, 0);

      yield HomeLoaded(userSettings, workflow, deviceList);
    }

    if (event is HomeSelectWorkflow) {
      // get current user
      final currentUser = MainState.get().currentUser;
      // get current settings
      final settings = MainState.get().settings;

      if (event.workflow != null) {
        // save workflow at user settings
        await Adaptors.get()
            .userSettings
            .setWorkflow(currentUser.id, event.workflow.id, settings.serverAddress);
      }
    }

    if (event is HomeUpdateFavoriteScenarioList) {
      if (event.scenarios == null) {
        return;
      }

      //print('selected scenarios' + event.scenarios.toString());

      // get current user
      final currentUser = MainState.get().currentUser;
      // get current settings
      final settings = MainState.get().settings;
      // get here user settings
      final userSettings =
          await Adaptors.get().userSettings.autoload(currentUser.id, settings.serverAddress);

      if (userSettings == null) {
        return;
      }

      userSettings.scenarios = event.scenarios;

      await Adaptors.get().userSettings.update(userSettings);
    }

    if (event is HomeUpdateFavoriteActionList) {
      if (event.actions == null) {
        return;
      }

      print('selected actions' + event.actions.toString());

      // get current user
      final currentUser = MainState.get().currentUser;
      // get current settings
      final settings = MainState.get().settings;
      // get here user settings
      final userSettings =
          await Adaptors.get().userSettings.autoload(currentUser.id, settings.serverAddress);

      if (userSettings == null) {
        return;
      }

      userSettings.actions = event.actions;

      await Adaptors.get().userSettings.update(userSettings);
    }

    if (event is HomeDoAction) {

      final actionId = event.action.deviceActionId;
      final deviceId = event.action.deviceId;

      print('call actionId: $actionId. deviceId $deviceId');

      final status = await Repository.get().stream.doAction(actionId, deviceId);
    }

    if (event is HomeSelectScenario) {
      await Repository.get().workflow.updateScenario(event.workflowId, event.scenarioId);
      final scenarios = await Repository.get().workflow.fetchScenariosList(event.workflowId);
      yield HomeLoadedScenarios(scenarios);
    }
  }
}
