import '../../data/models/activity/activity_model.dart';

abstract class ActivityRepository {
  Future<List<ActivityModel>> getAllActivities();
}
