import 'db.dart';

class Variable {
  Variable();

  String name;
  String value;
  int autoload;
  String createdAt, updatedAt;
}

class Variables {
  DBProvider _provider;

  Variables(this._provider);

  createOrUpdate(Variable variable) async {
    final db = await _provider.database;

    var res = await db
        .query("variables", where: "name = ?", whereArgs: [variable.name]);

    if (res.isEmpty) {
      var raw = await db.rawInsert(
          "INSERT Into variables (name, value, autoload, created_at)"
          " VALUES (?,?,?,?)",
          [
            variable.name,
            variable.value,
            variable.autoload,
            variable.createdAt,
          ]);
    } else {
      var raw = await db.rawInsert(
          "UPDATE variables SET value=?, updated_at=? where name=?", [
        variable.value,
        variable.updatedAt,
        variable.name,
      ]);
    }
  }

  Future<Map<String, dynamic>> get(String name) async {
    final db = await _provider.database;

    var res = await db.query("variables", where: "name = ?", whereArgs: [name]);

    return res.isNotEmpty ? res.first : null;
  }
}
