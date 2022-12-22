part of 'reminders_bloc.dart';

class RemindersState extends Equatable {
  final int index;

  const RemindersState({
    this.index = 0,
  });

  RemindersState copyWith({
    int? index,
  }) =>
      RemindersState(
        index: index ?? this.index,
      );

  @override
  List<Object> get props => [
        index,
      ];
}
