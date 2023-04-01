import '../entities/activity/activity_entity.dart';

abstract class ActivityRepositoryAbstract {
  Future<List<ActivityEntity>> getAllActivities();
}
