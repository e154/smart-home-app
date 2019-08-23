import 'package:equatable/equatable.dart';
import 'package:smart_home_app/models/setting.dart';

abstract class SettingsEvent extends Equatable {
  SettingsEvent([List props = const []]) : super(props);
}

class UpdateSettings extends SettingsEvent {
  Settings settings;

  UpdateSettings(this.settings);

  @override
  String toString() => 'UpdateSettings $settings';
}

class SettingsFetchSettings extends SettingsEvent {

  @override
  String toString() => 'SettingsFetchSettings';
}