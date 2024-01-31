import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/local_db_tables.dart';

class DBSqfliteService {
  static final DBSqfliteService _singleton = DBSqfliteService._();
  DBSqfliteService._();
  factory DBSqfliteService() {
    return _singleton;
  }

  // variables
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  initDB() async {
    final directory = await getDatabasesPath();
    final path = join(directory, kDBFile);
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        for (String sql in kDBDDL) {
          await db.execute(sql);
        }
      },
      version: 2,
    );
  }
}
