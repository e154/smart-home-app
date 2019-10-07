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
