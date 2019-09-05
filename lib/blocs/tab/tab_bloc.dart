import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/models/models.dart';

import 'tab_event.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.favorite;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
