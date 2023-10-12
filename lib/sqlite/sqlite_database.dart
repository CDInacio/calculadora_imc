import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

Map<int, String> scripts = {
  1: ''' CREATE TABLE IF NOT EXISTS imc (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          gender TEXT NOT NULL,
          height REAL NOT NULL,
          weight REAL NOT NULL,
        )
'''
};

class SqliteDataBase {
  static Database? db;

  Future<Database> getDatabase() async {
    if (db == null) {
      return await startDatabase();
    }
    return db!;
  }

  Future<Database> startDatabase() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: 1, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]!);
      }
    });
    return db;
  }
}
