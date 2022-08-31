import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc() : super(ActivitiesInitial()) {
    on<ActivitiesEvent>((event, emit) {});
  }
}
