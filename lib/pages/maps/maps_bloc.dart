import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'maps_event.dart';
import 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  @override
  // TODO: implement initialState
  MapsState get initialState => null;

  @override
  Stream<MapsState> mapEventToState(MapsEvent event) {
    // TODO: implement mapEventToState
    return null;
  }
}
