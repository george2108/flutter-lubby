part of 'todos_bloc.dart';

class TodosState extends Equatable {
  final List<ToDoModel> todos;
  final bool showFab;
  final TextEditingController searchInputController;
  final bool loading;

  TodosState({
    required this.todos,
    required this.searchInputController,
    this.showFab = true,
    this.loading = false,
  });

  TodosState copyWith({
    List<ToDoModel>? todos,
    bool? showFab,
    bool? loading,
  }) =>
      TodosState(
        todos: todos ?? this.todos,
        showFab: showFab ?? this.showFab,
        searchInputController: this.searchInputController,
        loading: loading ?? this.loading,
      );

  @override
  List<Object?> get props => [
        todos,
        showFab,
        searchInputController,
        loading,
      ];
}
