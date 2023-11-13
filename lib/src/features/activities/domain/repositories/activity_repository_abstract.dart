import '../entities/activity_entity.dart';

abstract class ActivityRepositoryAbstract {
  Future<List<ActivityEntity>> getAllActivities();
}
