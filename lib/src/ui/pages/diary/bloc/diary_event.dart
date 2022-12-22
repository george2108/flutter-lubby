part of 'diary_bloc.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();
}

class ChangePageEvent extends DiaryEvent {
  final int index;

  const ChangePageEvent(this.index);

  @override
  List<Object?> get props => [
        index,
      ];
}

class ChangeCalendarViewEvent extends DiaryEvent {
  final TypeCalendarViewEnum view;

  const ChangeCalendarViewEvent(this.view);

  @override
  List<Object?> get props => [view];
}
