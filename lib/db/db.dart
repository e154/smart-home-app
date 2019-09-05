import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

export 'variable.dart';
export 'user_settings.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  final dbName = "smartHomeApp.db";

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  _onOpen(Database db) async {
    print('db version ${await db.getVersion()}');
  }

  _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    return await openDatabase(
      path,
      version: DB_VERSION,
      onOpen: _onOpen,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
      onConfigure: _onConfigure,
    );
  }
}

_onCreate(Database db, int version) async {
  var batch = db.batch();

  batch.execute("CREATE TABLE variables ("
      "name Text NOT NULL,"
      "value Text NOT NULL,"
      "autoload bool,"
      "created_at DateTime NOT NULL,"
      "updated_at DateTime,"
      "PRIMARY KEY(name));");

  batch.execute("CREATE INDEX name_at_values_idx ON variables (name);");
  batch.execute("CREATE INDEX autoload_at_values_idx ON variables (autoload);");

  await batch.commit();
}

_onUpgrade(Database db, int oldVersion, int newVersion) async {
  var batch = db.batch();
  switch (oldVersion) {
    case 3:
      batch.execute("CREATE TABLE user_settings ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "user_id INTEGER NOT NULL,"
          "workflow_id INTEGER NULL,"
          "scenarios Text NOT NULL,"
          "actions Text NOT NULL,"
          "autoload bool NULL,"
          "created_at DateTime NOT NULL,"
          "updated_at DateTime,"
          "UNIQUE(user_id,workflow_id),"
          "UNIQUE(user_id,autoload));");

      batch.execute("CREATE INDEX autoload_at_user_settings_idx ON user_settings (autoload);");
      batch.execute("CREATE INDEX user_at_user_settings_idx ON user_settings (user_id);");

      break;
    case 4:
    default:
      Exception("unknown version: $oldVersion");
  }

  await batch.commit();
}

_onDowngrade(Database db, int oldVersion, int newVersion) async {
  var batch = db.batch();
  await batch.commit();
}
