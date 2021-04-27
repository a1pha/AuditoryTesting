import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName1 = 'mySounds';
  static final _tableName2 = 'myRoutines';

  static final column1ID = '_id';
  static final column1Sound = 'sound';
  static final column1Path = 'path';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.query('''
    CREATE TABLE $_tableName1(
    $column1ID INTEGER PRIMARY KEY,
    $column1Sound TEXT NOT NULL,
    $column1Path TEXT NOT NULL)
    ''');
  }

  Future<int> insert(Map<String, dynamic> row, String databasename) async {
    Database db = await instance.database;
    return await db.insert(databasename, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String databasename) async {
    Database db = await instance.database;
    return await db.query(databasename);
  }

  // Future<int> update(Map<String, dynamic> row, String databasename) async {
  //   Database db = await instance.database;
  //   db.update(databasename, row);
  // }
}
