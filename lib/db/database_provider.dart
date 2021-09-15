import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database? _database;
  static final DatabaseProvider db = DatabaseProvider._();
  DatabaseProvider._();

  List<String> consultas = [
    '''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        createdAt TIMESTAMP,
        important INTEGER DEFAULT 0,
        color VARCHAR(10) NOT NULL
      )
      ''',
    '''
      CREATE TABLE passwords(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        user TEXT NULL,
        password TEXT,
        description TEXT NULL,
        createdAt TIMESTAMP
      )
      ''',
    '''
      CREATE TABLE toDos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(50) NOT NULL,
        description TEXT NULL,
        complete INTEGER DEFAULT 0,
        createdAt TIMESTAMP
      )
      ''',
    '''
      CREATE TABLE toDosDetalle (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        toDoId int NOT NULL,
        description TEXT NULL,
        complete INTEGER DEFAULT 0,
        orderDetail INTEGER NULL,
        FOREIGN KEY (toDoId) REFERENCES toDos(id)
      )
      '''
  ];

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "lubby.db"),
        onCreate: (db, version) async {
      for (String sql in consultas) {
        await db.execute(sql);
      }
    }, version: 1);
  }

  /// NOTAS
  Future<void> addNewNote(NoteModel note) async {
    final db = await database;
    db.insert(
      "notes",
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await database;
    final res = await db.query("notes", orderBy: "createdAt DESC");
    if (res.length == 0) return [];
    final resultMap = res.toList();
    List<NoteModel> resultNotes = [];
    for (var i = 0; i < resultMap.length; i++) {
      final note = Map<String, dynamic>.from(resultMap[i]);
      final noteFromMap = NoteModel.fromMap(note);
      resultNotes.add(noteFromMap);
    }
    return resultNotes;
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db.rawDelete(
      "DELETE FROM notes WHERE id = ?",
      [id],
    );
    return count;
  }

  /// PASSWORDS
  Future<List<PasswordModel>> getAllPasswords() async {
    final db = await database;
    final res = await db.query("passwords", orderBy: "createdAt DESC");

    if (res.length == 0) return [];
    final resultMap = res.toList();
    List<PasswordModel> resultPasswords = [];
    for (var i = 0; i < resultMap.length; i++) {
      final pass = Map<String, dynamic>.from(resultMap[i]);
      final password = PasswordModel.fromMap(pass);
      resultPasswords.add(password);
    }
    return resultPasswords;
  }

  Future<void> addNewPassword(PasswordModel pass) async {
    final db = await database;
    db.insert(
      "passwords",
      pass.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deletePassword(int id) async {
    final db = await database;
    int count = await db.rawDelete(
      "DELETE FROM passwords WHERE id = ?",
      [id],
    );
    return count;
  }

  Future<int> updatePassword(PasswordModel password) async {
    final db = await database;
    return await db.rawUpdate('''
      UPDATE passwords SET 
      user = ?, 
      password = ?,
      description = ?,
      title = ? 
      WHERE id = ?
    ''', [
      '${password.user}',
      '${password.password}',
      '${password.description}',
      '${password.title}',
      '${password.id}',
    ]);
  }

  /// TAREAS

  Future<Map<String, dynamic>> getAllTasks() async {
    final db = await database;

    List<Map<String, dynamic>> incomplete = await db.query(
      "toDos",
      orderBy: "createdAt DESC",
      where: "complete = 0",
    );
    final incompleteMap = incomplete.toList();

    final complete = await db.query(
      "toDos",
      orderBy: "createdAt DESC",
      where: "complete = 1",
    );
    final completeMap = complete.toList();

    final resp = {
      "incomplete": incompleteMap.length > 0 ? incompleteMap : [],
      "complete": completeMap.length > 0 ? completeMap : [],
    };
    return resp;
  }

  Future<List> getTaskDetail(int id) async {
    final db = await database;

    final detail = await db.query(
      "toDosDetalle",
      orderBy: "orderDetail DESC",
      where: "toDoId = $id",
    );
    return detail.toList();
  }

  Future<void> addNewToDo(
    ToDoModel toDoModel,
    List<ToDoDetailModel> toDoDetailModel,
  ) async {
    final db = await database;
    final toDoId = await db.insert(
      "toDos",
      toDoModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (var i = 0; i < toDoDetailModel.length; i++) {
      toDoDetailModel[i].toDoId = toDoId;
      await db.insert(
        "toDosDetalle",
        toDoDetailModel[i].toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
