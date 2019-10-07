import 'package:smart_home_app/db/db.dart';
import 'user_settings.dart';
import 'variables.dart';

class Adaptors {
  VariableAdaptor variable;
  UserSettingsAdaptor userSettings;

  static final Adaptors _singleton = new Adaptors._internal();

  static Adaptors get() => _singleton;

  factory Adaptors() {
    return _singleton;
  }

  Adaptors._internal() {
    variable = new VariableAdaptor(DBProvider.db);
    userSettings = new UserSettingsAdaptor(DBProvider.db);
  }
}
