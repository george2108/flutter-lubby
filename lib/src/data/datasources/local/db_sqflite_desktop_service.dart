import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/local_db_tables.dart';

class DBSqfliteDesktopService {
  static final DBSqfliteDesktopService _singleton = DBSqfliteDesktopService._();
  DBSqfliteDesktopService._();
  factory DBSqfliteDesktopService() {
    return _singleton;
  }

  // variables
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  initDB() async {
    databaseFactory = databaseFactoryFfi;
    final directory = await getDatabasesPath();
    final path = join(directory, kDBFile);

    final db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 2,
        onCreate: (db, version) async {
          for (String sql in kDBDDL) {
            await db.execute(sql);
          }
        },
      ),
    );

    return db;
  }
}
