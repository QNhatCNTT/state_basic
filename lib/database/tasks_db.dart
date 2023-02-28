import 'dart:async';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:state_basic/models/task.dart';

class TaskDB {
  late Database database;
  final databaseName = 'tasks3.db';
  final _version = 1;
  static const tableName = 'task';
  static const tableQuery = '''
  CREATE TABLE $tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT ,
    description TEXT,
    createdTime TEXT ,
    status INTEGER
  )
  ''';
  Future<void> open() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath,databaseName);
    database = await openDatabase(path,version: _version, onCreate: (db, version) {
      return db.execute(tableQuery);
    });
  }

  Future<int> insert(Task task) async {
    await open();
    int id = await database.insert(
      tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await close();

    return id;
  }

  Future<List<Task>> getTasks() async {
    await open();
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    await close();
    return List.generate(
        maps.length,
        (index) => Task.fromMap(maps[index]));
  }

  Future<void> updateTask(Task task) async {
    await open();
    await database.update(tableName, task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
    await close();
  }

  Future<void> delete(String id) async {
    await open();
    database.delete(tableName, where: 'id = ?', whereArgs: [id]);
    await close();
  }

  Future close() async => database.close();
}
