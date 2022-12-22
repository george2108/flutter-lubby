import 'package:lubby_app/src/core/constants/db_tables_name_constants.dart';
import 'package:lubby_app/src/data/entities/activity/activity_entity.dart';

import '../db/database_service.dart';

class ActivitiesLocalService {
  static final ActivitiesLocalService provider =
      ActivitiesLocalService._internal();

  factory ActivitiesLocalService() {
    return provider;
  }

  ActivitiesLocalService._internal();

  ///
  /// Retornar listado de las actividades
  ///
  Future<List<ActivityEntity>> getAllActivities() async {
    final db = await DatabaseProvider.db.database;

    final res = await db.query(
      kActivitiesTable,
      orderBy: "favorite DESC, createdAt DESC",
    );

    if (res.isEmpty) return [];

    final resultMap = res.toList();
    List<ActivityEntity> resultActivities = [];

    for (var i = 0; i < resultMap.length; i++) {
      final activityJson = Map<String, dynamic>.from(resultMap[i]);
      final activity = ActivityEntity.fromMap(activityJson);
      resultActivities.add(activity);
    }

    return resultActivities;
  }
}
