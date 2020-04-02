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
        final mapList = await Repository.get().map.fetchList(10, 0, "DESC", "id");
        yield MapListLoaded(mapList);
      } catch (error) {
        yield MapsFailure(error: error.toString());
      }
    }
  }
}
