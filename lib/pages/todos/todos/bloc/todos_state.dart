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
  @override
  List<Object?> get props => [];
}
