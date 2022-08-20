part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class TodosLoadDataEvent extends TodosEvent {
  @override
  List<Object?> get props => [];
}
