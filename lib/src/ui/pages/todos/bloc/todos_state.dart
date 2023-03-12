part of 'todos_bloc.dart';

class TodosState extends Equatable {
  final DateTime dateTasks;

  final List<ToDoEntity> todosLists;
  final List<ToDoDetailEntity> tasks;

  final bool loadingTodosLists;
  final bool loadingTasks;

  // detalle de una lista
  final ToDoEntity? taskLoaded;
  final List<ToDoDetailEntity> taskDetailsLoaded;
  final bool loadingTaskDetailsLoaded;

  const TodosState({
    required this.todosLists,
    required this.dateTasks,
    required this.tasks,
    this.loadingTodosLists = false,
    this.loadingTasks = false,
    this.taskLoaded,
    this.taskDetailsLoaded = const [],
    this.loadingTaskDetailsLoaded = false,
  });

  TodosState copyWith({
    List<ToDoEntity>? todosLists,
    List<ToDoDetailEntity>? tasks,
    bool? loadingTodosLists,
    DateTime? dateTasks,
    bool? loadingTasks,
    ToDoEntity? taskLoaded,
    List<ToDoDetailEntity>? taskDetailsLoaded,
    bool? loadingTaskDetailsLoaded,
  }) =>
      TodosState(
        todosLists: todosLists ?? this.todosLists,
        loadingTodosLists: loadingTodosLists ?? this.loadingTodosLists,
        dateTasks: dateTasks ?? this.dateTasks,
        loadingTasks: loadingTasks ?? this.loadingTasks,
        tasks: tasks ?? this.tasks,
        taskLoaded: taskLoaded ?? this.taskLoaded,
        taskDetailsLoaded: taskDetailsLoaded ?? this.taskDetailsLoaded,
        loadingTaskDetailsLoaded:
            loadingTaskDetailsLoaded ?? this.loadingTaskDetailsLoaded,
      );

  @override
  List<Object?> get props => [
        todosLists,
        loadingTodosLists,
        dateTasks,
        loadingTasks,
        tasks,
        taskLoaded,
        taskDetailsLoaded,
        loadingTaskDetailsLoaded,
      ];
}
