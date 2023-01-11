import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:lubby_app/src/core/constants/db_tables_name_constants.dart';

class DatabaseProvider {
  static Database? _database;
  static final DatabaseProvider db = DatabaseProvider._();
  DatabaseProvider._();

  List<String> consultas = [
    '''
      CREATE TABLE $kLabelsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        icon TEXT NOT NULL,
        color VARCHAR(10) NOT NULL,
        type VARCHAR(150) NOT NULL
      )
      ''',
    '''
      CREATE TABLE $kNotesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        createdAt TIMESTAMP,
        favorite INTEGER DEFAULT 0,
        color VARCHAR(10) NOT NULL
      )
      ''',
    '''
      CREATE TABLE $kPasswordsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        user TEXT NULL,
        password TEXT,
        description TEXT NULL,
        createdAt TIMESTAMP,
        favorite INTEGER DEFAULT 0,
        url TEXT NULL,
        notas TEXT NULL,
        color VARCHAR(10) NOT NULL
      )
      ''',
    '''
      CREATE TABLE $kTodosTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(50) NOT NULL,
        description TEXT NULL,
        complete INTEGER DEFAULT 0,
        createdAt TIMESTAMP,
        favorite INTEGER DEFAULT 0,
        totalItems INTEGER DEFAULT 0,
        percentCompleted INTEGER DEFAULT 0,
        color VARCHAR(10) NOT NULL
      )
      ''',
    '''
      CREATE TABLE $kTodosDetailTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        toDoId int NULL,
        title VARCHAR(100) NOT NULL,
        description TEXT NULL,
        startDate DATE NULL,
        startTime TIME NULL,
        complete INTEGER DEFAULT 0,
        orderDetail INTEGER NULL,
        FOREIGN KEY (toDoId) REFERENCES $kTodosTable(id)
      )
      ''',
    '''
      CREATE TABLE $kTodosDetailStateTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        toDoDetailId int NULL,
        dateAffected DATE NULL,
        timeAffected TIME NULL,
        complete INTEGER DEFAULT 0,
        FOREIGN KEY (toDoDetailId) REFERENCES $kTodosDetailTable(id)
      )
      ''',
    '''
      CREATE TABLE $kActivitiesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        createdAt TIMESTAMP,
        favorite INTEGER DEFAULT 0
      )
      ''',
    '''
      CREATE TABLE $kActivitiesListsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        createdAt TIMESTAMP,
        orderDetail INTEGER NULL,
        activityId int NOT NULL,
        FOREIGN KEY (activityId) REFERENCES $kActivitiesTable(id)
      )
      ''',
    '''
      CREATE TABLE $kActivitiesCardsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        description TEXT NULL,
        color VARCHAR(10) NOT NULL,
        createdAt TIMESTAMP,
        dateLimit TIMESTAMP,
        orderDetail INTEGER NULL,
        acitvityListId int NOT NULL,
        FOREIGN KEY (acitvityListId) REFERENCES $kActivitiesListsTable(id)
      )
      ''',
  ];

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  initDB() async {
    final directory = await getDatabasesPath();
    final path = join(directory, "lubby.db");
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        for (String sql in consultas) {
          await db.execute(sql);
        }
      },
      version: 2,
    );
  }
}
