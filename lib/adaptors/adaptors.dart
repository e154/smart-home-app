import 'package:smart_home_app/db/db.dart';
import 'variables.dart';

class Adaptors {
  VariableAdaptor variable;

  static final Adaptors _singleton = new Adaptors._internal();

  factory Adaptors() {
    return _singleton;
  }

  Adaptors._internal() {
    variable = new VariableAdaptor(DBProvider.db);
  }
}
