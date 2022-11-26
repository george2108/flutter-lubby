import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(const DiaryState()) {
    on<ChangePageEvent>(changePageEvent);
  }

  changePageEvent(ChangePageEvent event, Emitter<DiaryState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
