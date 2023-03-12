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
        color INT NOT NULL,
        type VARCHAR(150) NOT NULL
      )
      ''',
    '''
      CREATE TABLE $kNotesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        createdAt TIMESTAMP,
        favorite INTEGER(1) DEFAULT 0,
        color INT NOT NULL,
        labelId INTEGER NULL,
        FOREIGN KEY (labelId) REFERENCES $kLabelsTable(id)
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
        favorite INTEGER(1) DEFAULT 0,
        url TEXT NULL,
        notas TEXT NULL,
        color INT NOT NULL,
        icon TEXT NOT NULL,
        labelId INTEGER NULL,
        FOREIGN KEY (labelId) REFERENCES $kLabelsTable(id)
      )
      ''',
    '''
      CREATE TABLE $kTodosTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(50) NOT NULL,
        description TEXT NULL,
        complete INTEGER DEFAULT 0,
        createdAt TIMESTAMP,
        favorite INTEGER(1) DEFAULT 0,
        totalItems INTEGER DEFAULT 0,
        percentCompleted INTEGER DEFAULT 0,
        color INT NOT NULL
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
        complete INTEGER(1) DEFAULT 0,
        orderDetail INTEGER NULL,
        FOREIGN KEY (toDoId) REFERENCES $kTodosTable(id)
      )
      ''',
    '''
      CREATE TABLE $kTodosDetailStateTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        toDoDetailId INT NULL,
        dateAffected DATE NULL,
        timeAffected TIME NULL,
        complete INTEGER(1) DEFAULT 0,
        FOREIGN KEY (toDoDetailId) REFERENCES $kTodosDetailTable(id)
      )
      ''',
    '''
      CREATE TABLE $kActivitiesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        createdAt TIMESTAMP,
        favorite INTEGER(1) DEFAULT 0
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
        color INT NOT NULL,
        createdAt TIMESTAMP,
        dateLimit TIMESTAMP,
        orderDetail INTEGER NULL,
        acitvityListId int NOT NULL,
        FOREIGN KEY (acitvityListId) REFERENCES $kActivitiesListsTable(id)
      )
      ''',
    '''
      CREATE TABLE $kAccountsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        labelId INTEGER NULL,
        name TEXT NOT NULL,
        description TEXT NULL,
        balance REAL NOT NULL,
        createdAt TIMESTAMP,
        icon TEXT NOT NULL,
        color INT NOT NULL,
        FOREIGN KEY (labelId) REFERENCES $kLabelsTable(id)
      )
      ''',
    '''
      CREATE TABLE $kTransactionsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        accountId INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT NULL,
        amount REAL NOT NULL,
        createdAt TIMESTAMP,
        type VARCHAR(20) NOT NULL,
        FOREIGN KEY (accountId) REFERENCES $kAccountsTable(id)
      )
      ''',
    '''
      CREATE TABLE $kDiaryTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        startDate TIMESTAMP,
        endDate TIMESTAMP NULL,
        startTime TIME NULL,
        endTime TIME NULL,
        labelId INTEGER NULL,
        color INT NOT NULL,
        typeRepeat VARCHAR(20) NOT NULL,
        daysRepeat VARCHAR(200) NOT NULL,
        FOREIGN KEY (labelId) REFERENCES $kLabelsTable(id)
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
