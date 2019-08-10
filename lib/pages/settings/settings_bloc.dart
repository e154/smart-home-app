import 'package:bloc/bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc();

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {}
}
