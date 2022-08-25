part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();
}

class TodosInitialState extends TodosState {
  @override
  List<Object?> get props => [];
}

class TodosLoadingState extends TodosState {
  @override
  List<Object?> get props => [];
}

class TodosLoadedState extends TodosState {
  final List<ToDoModel> todos;
  final bool showFab;

  TodosLoadedState(this.todos, this.showFab);

  TodosLoadedState copyWith({bool? showFab}) => TodosLoadedState(
        this.todos,
        showFab ?? this.showFab,
      );

  @override
  List<Object?> get props => [todos, showFab];
}
