part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class GetTodosListsEvent extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class GetTasksEvent extends TodosEvent {
  @override
  List<Object?> get props => [];
}
