part of 'activities_bloc.dart';

class ActivitiesState extends Equatable {
  final List<ActivityModel> activities;
  final bool loading;

  const ActivitiesState({
    required this.activities,
    this.loading = false,
  });

  ActivitiesState copyWith({
    List<ActivityModel>? activities,
    bool? loading,
  }) =>
      ActivitiesState(
        activities: activities ?? this.activities,
        loading: loading ?? this.loading,
      );

  @override
  List<Object> get props => [
        activities,
        loading,
      ];
}
