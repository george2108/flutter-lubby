import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/data/datasources/local/services/activities_local_service.dart';
import 'package:lubby_app/src/data/models/activity/activity_model.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc()
      : super(
          const ActivitiesState(
            activities: [],
          ),
        ) {
    on<LoadActivitiesEvent>(_loadActivities);
  }

  _loadActivities(
    LoadActivitiesEvent event,
    Emitter<ActivitiesState> emit,
  ) async {
    try {
      state.copyWith(loading: true);
      final activities =
          await ActivitiesLocalService.provider.getAllActivities();
      state.copyWith(
        activities: activities,
        loading: false,
      );
    } catch (e) {
      state.copyWith(loading: false);
      print(e);
    }
  }
}