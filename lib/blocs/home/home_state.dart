import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class HomeInitial extends HomeState {
  @override
  String toString() => 'HomeInitial';
}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'HomeFailure { error: $error }';
}

class HomeLoading extends HomeState {
  @override
  String toString() => 'HomeLoading';
}

class HomeLoaded extends HomeState {
  UserSettings _userSettings;
  Workflow _workflow;
  List<MapElement> _deviceList;

  HomeLoaded(this._userSettings, this._workflow, this._deviceList);

  Workflow get workflow => _workflow;
  UserSettings get userSettings => _userSettings;
  List<MapElement> get deviceList => _deviceList;

  @override
  String toString() => 'HomeLoaded';
}
