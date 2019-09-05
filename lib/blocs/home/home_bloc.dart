import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/common/common.dart';
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
      final userSettings = await Adaptors.get().userSettings.autoload(currentUser.id);

      if (userSettings == null) {
        yield HomeLoaded(userSettings, null);
        return;
      }

      final workflow = await Repository.get().workflow.getById(userSettings.workflowId);
      yield HomeLoaded(userSettings, workflow);
    }

    if (event is HomeSelectWorkflow) {
      // get current user
      final currentUser = MainState.get().currentUser;

      if (event.workflow != null) {
        // save workflow at user settings
        await Adaptors.get().userSettings.setWorkflow(currentUser.id, event.workflow.id);
      }
    }
  }
}
