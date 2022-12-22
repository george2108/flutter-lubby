part of 'diary_bloc.dart';

class DiaryState extends Equatable {
  final int index;
  final TypeCalendarViewEnum viewCalendar;

  const DiaryState({
    this.index = 0,
    this.viewCalendar = TypeCalendarViewEnum.month,
  });

  DiaryState copyWith({
    int? index,
    TypeCalendarViewEnum? viewCalendar,
  }) =>
      DiaryState(
        index: index ?? this.index,
        viewCalendar: viewCalendar ?? this.viewCalendar,
      );

  @override
  List<Object> get props => [
        index,
        viewCalendar,
      ];
}
