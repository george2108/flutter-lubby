part of 'todos_bloc.dart';

class TodosState extends Equatable {
  final List<ToDoEntity> todos;
  final bool showFab;
  final TextEditingController searchInputController;
  final bool loading;

  final int index;

  const TodosState({
    required this.todos,
    required this.searchInputController,
    this.showFab = true,
    this.loading = false,
    this.index = 0,
  });

  TodosState copyWith({
    List<ToDoEntity>? todos,
    bool? showFab,
    bool? showFabTasks,
    bool? loading,
    int? index,
  }) =>
      TodosState(
        todos: todos ?? this.todos,
        showFab: showFab ?? this.showFab,
        searchInputController: searchInputController,
        loading: loading ?? this.loading,
        index: index ?? this.index,
      );

  @override
  List<Object?> get props => [
        todos,
        showFab,
        searchInputController,
        loading,
        index,
      ];
}
