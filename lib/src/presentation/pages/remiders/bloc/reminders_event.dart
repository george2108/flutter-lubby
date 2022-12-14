part of 'reminders_bloc.dart';

abstract class RemindersEvent extends Equatable {
  const RemindersEvent();
}

class ChangePageEvent extends RemindersEvent {
  final int index;

  const ChangePageEvent(this.index);

  @override
  List<Object?> get props => [index];
}
