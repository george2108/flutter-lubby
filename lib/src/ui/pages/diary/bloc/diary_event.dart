part of 'diary_bloc.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();
}

class GetDiariesResumeEvent extends DiaryEvent {
  final DateTime date;

  const GetDiariesResumeEvent(this.date);

  @override
  List<Object> get props => [];
}

class DiaryAddEvent extends DiaryEvent {
  final DiaryEntity diary;

  const DiaryAddEvent(this.diary);

  @override
  List<Object> get props => [diary];
}
