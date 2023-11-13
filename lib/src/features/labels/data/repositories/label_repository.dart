import 'package:sqflite/sqflite.dart';

import '../../../../core/constants/db_tables_name_constants.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../../domain/repositories/label_repository_abstract.dart';
import '../../../../data/datasources/local/db/database_service.dart';
import '../../domain/entities/label_entity.dart';

class LabelRepository extends LabelRepositoryAbstract {
  @override
  Future<int> addNewLabel(LabelEntity label) async {
    final db = await DatabaseProvider.db.database;
    return await db.insert(
      kLabelsTable,
      label.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<LabelEntity> getLabelById(int id) async {
    final db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      kLabelsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    return LabelEntity.fromMap(maps[0]);
  }

  @override
  Future<int> deleteLabel(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<LabelEntity>> getLabels(List<TypeLabels> type) async {
    final db = await DatabaseProvider.db.database;
    final types = type.map((e) => '"${e.name.toString()}"').join(',');
    final List<Map<String, dynamic>> maps = await db.query(
      kLabelsTable,
      where: 'type IN ($types)',
    );
    return List.generate(maps.length, (i) {
      return LabelEntity.fromMap(maps[i]);
    });
  }

  @override
  Future<List<LabelEntity>> searchLabel(String term) {
    throw UnimplementedError();
  }

  @override
  Future<int> updateLabel(LabelEntity label) {
    throw UnimplementedError();
  }
}
