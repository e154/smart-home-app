import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/repositories/repository.dart';

import 'maps_event.dart';
import 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {

  MapsBloc();

  @override
  MapsState get initialState => MapsInitial();

  @override
  Stream<MapsState> mapEventToState(MapsEvent event) async* {
    if (event is FetchMapList) {
      try {
        yield LoadMapList();
        final mapList = await Repository.get().map.fetchList();
        yield MapListLoaded(mapList);
      } catch (error) {
        yield MapsFailure(error: error.toString());
      }
    }
  }
}
