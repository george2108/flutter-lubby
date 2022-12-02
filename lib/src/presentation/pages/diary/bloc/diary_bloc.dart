import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/presentation/pages/diary/enums/type_calendar_view_enum.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(const DiaryState()) {
    on<ChangePageEvent>(changePageEvent);

    on<ChangeCalendarViewEvent>(changeCalendarViewEvent);
  }

  changePageEvent(ChangePageEvent event, Emitter<DiaryState> emit) {
    emit(state.copyWith(index: event.index));
  }

  changeCalendarViewEvent(
    ChangeCalendarViewEvent event,
    Emitter<DiaryState> emit,
  ) {
    emit(
      state.copyWith(viewCalendar: event.view),
    );
  }
}
