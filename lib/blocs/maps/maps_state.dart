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

abstract class MapsState extends Equatable {
  MapsState([List props = const []]) : super(props);
}

class MapsInitial extends MapsState {
  @override
  String toString() => 'MapsInitial';
}

class LoadMapList extends MapsState {
  @override
  String toString() => 'LoadMapList';
}

class MapListLoaded extends MapsState {
  List<MapShort> mapList;

  MapListLoaded(this.mapList) {
    if (mapList == null) {
      mapList = List<MapShort>();
    }
  }

  @override
  String toString() => 'MapListLoaded';
}

class MapsFailure extends MapsState {
  final String error;

  MapsFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'MapsFailure { error: $error }';
}
