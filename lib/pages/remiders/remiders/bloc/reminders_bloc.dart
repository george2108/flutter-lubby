import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reminders_event.dart';
part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc() : super(RemindersInitial()) {
    on<RemindersEvent>((event, emit) {});
  }
}
