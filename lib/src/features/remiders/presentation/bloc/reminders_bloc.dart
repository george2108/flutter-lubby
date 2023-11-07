import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reminders_event.dart';
part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc() : super(const RemindersState()) {
    on<ChangePageEvent>(changePage);
  }

  changePage(ChangePageEvent event, Emitter<RemindersState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
