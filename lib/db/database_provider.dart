import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todo/type_filter_enum.dart';
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

  Future<List<NoteModel>> searchNote(String term) async {
    final db = await database;
    final results = await db.query(
      'notes',
      where: 'title LIKE "%${term}%" OR body LIKE "%${term}%"',
    );
    if (results.length == 0) return [];
    return results.map((e) => NoteModel.fromMap(e)).toList();
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

  Future<List<PasswordModel>> searchPassword(String term) async {
    final db = await database;
    final results = await db.query(
      'passwords',
      where: 'title LIKE "%${term}%"',
    );
    if (results.length == 0) return [];
    return results.map((e) => PasswordModel.fromMap(e)).toList();
  }

  /// TAREAS

  Future<List<ToDoModel>> getTasks({
    required TypeFilter type,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    final db = await database;
    String whereClause = "complete = ? ";
    if (fechaInicio != null) {
      whereClause += "AND createdAt BETWEEN ? AND ?";
    }
    final whereArgs = fechaInicio != null
        ? [
            type == TypeFilter.enProceso ? '0' : '1',
            '${fechaInicio.year.toString()}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')} 00:00:00',
            '${fechaFin?.year.toString()}-${fechaFin?.month.toString().padLeft(2, '0')}-${fechaFin?.day.toString().padLeft(2, '0')} 23:59:59',
          ]
        : [
            type == TypeFilter.enProceso ? '0' : '1',
          ];
    List<Map<String, dynamic>> tasks = await db.query(
      "toDos",
      orderBy: "createdAt DESC",
      where: whereClause,
      whereArgs: whereArgs,
    );
    final resp = tasks.toList();

    List<ToDoModel> resultTasks = [];
    for (var i = 0; i < tasks.length; i++) {
      final task = Map<String, dynamic>.from(resp[i]);
      final taskModel = ToDoModel.fromMap(task);
      resultTasks.add(taskModel);
    }
    return resultTasks;
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

  Future<int> addNewToDo(
    ToDoModel toDoModel,
  ) async {
    final db = await database;
    return await db.insert(
      "toDos",
      toDoModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> addNewDetailTask(ToDoDetailModel detailModel) async {
    final db = await database;
    await db.insert(
      "toDosDetalle",
      detailModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
