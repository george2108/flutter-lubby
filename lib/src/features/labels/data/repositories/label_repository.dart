import '../../../../core/constants/db_tables_name_constants.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../../../../data/datasources/local/database_service.dart';
import '../../../../data/datasources/remote/http_service.dart';
import '../../../../data/datasources/remote/sync_server_service.dart';
import '../../domain/repositories/label_repository_abstract.dart';
import '../../domain/entities/label_entity.dart';

class LabelRepository extends LabelRepositoryAbstract {
  final HttpService httpService;
  final SyncServerService syncServerService;

  LabelRepository({
    required this.httpService,
    required this.syncServerService,
  });

  @override
  Future<int> addNewLabel(LabelEntity label) async {
    final data = label.toMap();

    try {
      final response = await syncServerService.syncElements(data, "labels");

      if (response?.data['id'] != null) {
        data['id'] = response?.data['id'];
      }

      return await DatabaseService().save(
        kLabelsTable,
        data,
      );
    } catch (e) {
      return await DatabaseService().save(
        kLabelsTable,
        data,
      );
    }
  }

  @override
  Future<LabelEntity> getLabelById(int id) async {
    final List<Map<String, dynamic>> maps = await DatabaseService().find(
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
    final types = type.map((e) => '"${e.name.toString()}"').join(',');
    final List<Map<String, dynamic>> maps = await DatabaseService().find(
      kLabelsTable,
      where: 'type IN ($types)',
    );

    if (maps.isEmpty) {
      return [];
    }

    final resultMap = maps.toList();
    List<LabelEntity> resultLabels = [];

    for (var i = 0; i < resultMap.length; i++) {
      final label = Map<String, dynamic>.from(resultMap[i]);
      final labelFinal = LabelEntity.fromMap(label);
      resultLabels.add(labelFinal);
    }

    return resultLabels;
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
