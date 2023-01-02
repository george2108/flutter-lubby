part of 'todos_bloc.dart';

class TodosState extends Equatable {
  final DateTime dateTasks;

  final List<ToDoEntity> todosLists;
  final List<ToDoDetailEntity> tasks;

  final bool loadingTodosLists;
  final bool loadingTasks;

  const TodosState({
    required this.todosLists,
    required this.dateTasks,
    required this.tasks,
    this.loadingTodosLists = false,
    this.loadingTasks = false,
  });

  TodosState copyWith({
    List<ToDoEntity>? todosLists,
    List<ToDoDetailEntity>? tasks,
    bool? loadingTodosLists,
    DateTime? dateTasks,
    bool? loadingTasks,
  }) =>
      TodosState(
        todosLists: todosLists ?? this.todosLists,
        loadingTodosLists: loadingTodosLists ?? this.loadingTodosLists,
        dateTasks: dateTasks ?? this.dateTasks,
        loadingTasks: loadingTasks ?? this.loadingTasks,
        tasks: tasks ?? this.tasks,
      );

  @override
  List<Object?> get props => [
        todosLists,
        loadingTodosLists,
        dateTasks,
        loadingTasks,
        tasks,
      ];
}
