import 'package:bloc/bloc.dart';
import 'package:smart_home_app/adaptors/adaptors.dart';
import 'package:smart_home_app/models/setting.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Adaptors _adaptors;

  SettingsBloc() {
    _adaptors = new Adaptors();
  }

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is FetchSettings) {
      yield SettingsLoading();
      Settings settings = await _adaptors.variable.getSettings();
      yield SettingsLoaded(settings);
    }
    if (event is UpdateSettings) {
      _adaptors.variable.updateSettings(event.settings);
    }
  }

  Future<Settings> getSettings() => _adaptors.variable.getSettings();
}
