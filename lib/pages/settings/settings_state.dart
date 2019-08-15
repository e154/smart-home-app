import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_home_app/models/setting.dart';

abstract class SettingsState extends Equatable {
  SettingsState([List props = const []]) : super(props);
}

class SettingsInitial extends SettingsState {
  @override
  String toString() => 'SettingsInitial';
}

class SettingsLoaded extends SettingsState {
  Settings settings;

  SettingsLoaded(this.settings);

  @override
  String toString() => 'SettingsLoaded';
}

class SettingsLoading extends SettingsState {

  @override
  String toString() => 'SettingsLoading';
}

class SettingsFailure extends SettingsState {
  final String error;

  SettingsFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'SettingsFailure { error: $error }';
}
