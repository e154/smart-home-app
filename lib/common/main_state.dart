import 'package:smart_home_app/models/models.dart';

class MainState {
  Settings _settings;
  String _currentUserToken, _currentServerToken;
  User _currentUser;

  // ignore: unnecessary_getters_setters
  Settings get settings => _settings;
  // ignore: unnecessary_getters_setters
  set settings(Settings settings) => _settings = settings;

  // ignore: unnecessary_getters_setters
  User get currentUser => _currentUser;
  // ignore: unnecessary_getters_setters
  set currentUser(User currentUser) => _currentUser = currentUser;

  // ignore: unnecessary_getters_setters
  String get currentUserToken => _currentUserToken;
  // ignore: unnecessary_getters_setters
  set currentUserToken(String currentUserToken) => _currentUserToken = currentUserToken;

  // ignore: unnecessary_getters_setters
  String get currentServerToken => _currentServerToken;
  // ignore: unnecessary_getters_setters
  set currentServerToken(String currentServerToken) => _currentServerToken = currentServerToken;

  static final MainState _singleton = new MainState._internal();

  static MainState get() => _singleton;

  factory MainState() {
    return _singleton;
  }

  MainState._internal();
}
