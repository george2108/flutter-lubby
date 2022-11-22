import 'package:lubby_app/core/constants/db_tables_name_constants.dart';
import 'package:lubby_app/models/activity/activity_model.dart';

import 'database_provider.dart';

class ActivitiesDatabaseProvider {
  static final ActivitiesDatabaseProvider provider =
      ActivitiesDatabaseProvider._internal();

  factory ActivitiesDatabaseProvider() {
    return provider;
  }

  ActivitiesDatabaseProvider._internal();

  ///
  /// Retornar listado de las actividades
  ///
  Future<List<ActivityModel>> getAllActivities() async {
    final db = await DatabaseProvider.db.database;

    final res = await db.query(
      kActivitiesTable,
      orderBy: "favorite DESC, createdAt DESC",
    );

    if (res.isEmpty) return [];

    final resultMap = res.toList();
    List<ActivityModel> resultActivities = [];

    for (var i = 0; i < resultMap.length; i++) {
      final activityJson = Map<String, dynamic>.from(resultMap[i]);
      final activity = ActivityModel.fromMap(activityJson);
      resultActivities.add(activity);
    }

    return resultActivities;
  }
}
