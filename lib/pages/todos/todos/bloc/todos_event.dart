part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class TodosLoadDataEvent extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class TodosShowFabEvent extends TodosEvent {
  final bool showFab;

  TodosShowFabEvent(this.showFab);

  @override
  List<Object?> get props => [showFab];
}
