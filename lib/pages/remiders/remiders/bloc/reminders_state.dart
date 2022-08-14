part of 'reminders_bloc.dart';

abstract class RemindersState extends Equatable {
  const RemindersState();
  
  @override
  List<Object> get props => [];
}

class RemindersInitial extends RemindersState {}
