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

  UserSettings get userSettings => _userSettings;

  HomeLoaded(this._userSettings);

  @override
  String toString() => 'HomeLoaded';
}
