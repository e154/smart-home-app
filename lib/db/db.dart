/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home-app
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

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

  batch.execute("CREATE TABLE user_settings ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "user_id INTEGER NOT NULL,"
      "workflow_id INTEGER NULL,"
      "scenarios Text NOT NULL,"
      "actions Text NOT NULL,"
      "autoload bool NULL,"
      "server_address Text NULL,"
      "created_at DateTime NOT NULL,"
      "updated_at DateTime,"
      "UNIQUE(user_id,workflow_id, server_address),"
      "UNIQUE(user_id,autoload));");

  batch.execute("CREATE INDEX autoload_at_user_settings_idx ON user_settings (autoload);");
  batch.execute("CREATE INDEX user_at_user_settings_idx ON user_settings (user_id);");
  batch.execute("CREATE INDEX server_address_at_user_settings_idx ON user_settings (server_address);");

  await batch.commit();
}

_onUpgrade(Database db, int oldVersion, int newVersion) async {
  var batch = db.batch();
  switch (oldVersion) {
    case 3:
    case 4:
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
    case 5:
      batch.execute("ALTER TABLE user_settings "
          "ADD COLUMN server_address Text;"
      );
      batch.execute("CREATE INDEX server_address_at_user_settings_idx ON user_settings (server_address);");
      break;
    case 6:
    default:
      Exception("unknown version: $oldVersion");
  }

  await batch.commit();
}

_onDowngrade(Database db, int oldVersion, int newVersion) async {
  var batch = db.batch();
  await batch.commit();
}
