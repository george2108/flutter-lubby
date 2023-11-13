import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/diary_entity.dart';
import '../../data/repositories/diary_repository.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final DiaryRepository _diaryRepository;

  DiaryBloc(this._diaryRepository) : super(const DiaryState()) {
    on<DiaryAddEvent>(addDiary);

    on<GetDiariesResumeEvent>(getDiariesOneDate);
  }

  getDiariesOneDate(
    GetDiariesResumeEvent event,
    Emitter<DiaryState> emit,
  ) async {
    final diaries = await _diaryRepository.getDiariesOneDate(event.date);
    emit(state.copyWith(diariesOneDate: diaries));
  }

  addDiary(DiaryAddEvent event, Emitter<DiaryState> emit) async {
    final id = await _diaryRepository.addDiary(event.diary);
    final copyDiaries = List<DiaryEntity>.from(state.diariesOneDate);
    final newDiary = event.diary.copyWith(id: id);
    copyDiaries.add(newDiary);
    emit(state.copyWith(diariesOneDate: copyDiaries));
  }
}
