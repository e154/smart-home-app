import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/repositories/repository.dart';

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
      // get here user settings
      final userSettings =
          await Adaptors.get().userSettings.autoload(currentUser.id);

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

      if (event.workflow != null) {
        // save workflow at user settings
        await Adaptors.get()
            .userSettings
            .setWorkflow(currentUser.id, event.workflow.id);
      }
    }

    if (event is HomeUpdateFavoriteScenarioList) {
      if (event.scenarios == null) {
        return;
      }

      //print('selected scenarios' + event.scenarios.toString());

      // get current user
      final currentUser = MainState.get().currentUser;
      // get here user settings
      final userSettings =
          await Adaptors.get().userSettings.autoload(currentUser.id);

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
      // get here user settings
      final userSettings =
      await Adaptors.get().userSettings.autoload(currentUser.id);

      if (userSettings == null) {
        return;
      }

      userSettings.actions = event.actions;

      await Adaptors.get().userSettings.update(userSettings);
    }

    if (event is HomeDoAction) {
      if (event.action == null) {
        return;
      }

      print('call action: ' + event.action.id.toString());

      Repository.get().stream.doAction(event.action.id, event.action.deviceId);
    }
  }
}
