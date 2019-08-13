import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

export 'variable.dart';

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
      version: 3,
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
  await batch.commit();
}

_onDowngrade(Database db, int oldVersion, int newVersion) async {
  var batch = db.batch();
  await batch.commit();
}
