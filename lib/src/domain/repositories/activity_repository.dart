import '../../data/entities/activity/activity_entity.dart';

abstract class ActivityRepository {
  Future<List<ActivityEntity>> getAllActivities();
}
