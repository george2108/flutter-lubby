part of 'reminder_bloc.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();
  
  @override
  List<Object> get props => [];
}

class ReminderInitial extends ReminderState {}
