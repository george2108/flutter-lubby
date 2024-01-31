import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/routes.dart';
import '../../../../config/routes_settings/todo_route_settings.dart';
import '../../../../data/datasources/local/todos_local_service.dart';
import '../../domain/entities/todo_entity.dart';
import '../../data/repositories/todo_repository.dart';
import '../enum/type_filter_enum.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository _todoRepository;

  TodosBloc(this._todoRepository)
      : super(TodosState(
          todosLists: const [],
          tasks: const [],
          dateTasks: DateTime.now(),
        )) {
    on<GetTodosListsEvent>(getTodosLists);

    on<GetTasksEvent>(getTasks);

    on<NavigateToDetailEvent>(navigateToDoDetail);

    on<TodoAddTaskEvent>(addTask);

    on<TodoReorderDetailEvent>(reorderDetail);

    on<TodoMarkCheckDetailEvent>(markCheckTask);

    on<TodoDeleteDetailEvent>(deleteDetail);

    on<TodoEditDetailEvent>(editDetail);

    on<TodoGetDetailsByTodoIdEvent>(getDetails);
  }

  getTodosLists(GetTodosListsEvent event, Emitter<TodosState> emit) async {
    emit(state.copyWith(loadingTodosLists: true));

    await Future.delayed(const Duration(seconds: 2));

    final todosLists = await TodosLocalService.provider.getToDosLists(
      type: TypeFilterEnum.enProceso,
    );

    emit(state.copyWith(
      todosLists: todosLists,
      loadingTodosLists: false,
    ));
  }

  navigateToDoDetail(
    NavigateToDetailEvent event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(loadingTaskDetailsLoaded: true));

    final details = await _todoRepository.getToDoDetails(event.todo.id!);

    emit(state.copyWith(
      taskLoaded: event.todo,
      taskDetailsLoaded: details,
      loadingTaskDetailsLoaded: false,
    ));

    // ignore: use_build_context_synchronously
    Navigator.of(event.blocContext).pushNamed(
      toDoRoute,
      arguments: TodoRouteSettings(
        todoContext: event.blocContext,
        todo: event.todo,
      ),
    );
  }

  getTasks(GetTasksEvent event, Emitter<TodosState> emit) async {
    emit(state.copyWith(loadingTasks: true));

    await Future.delayed(const Duration(seconds: 2));

    final tasks = await TodosLocalService.provider.getTasks(
      fecha: state.dateTasks,
    );

    emit(state.copyWith(
      tasks: tasks,
      loadingTodosLists: false,
    ));
  }

  getDetails(
    TodoGetDetailsByTodoIdEvent event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(loadingTaskDetailsLoaded: true));
    final data = await TodosLocalService.provider.getTaskDetail(event.todoId);
    emit(
      state.copyWith(
        taskDetailsLoaded: data,
        loadingTaskDetailsLoaded: false,
      ),
    );
  }

  addTask(TodoAddTaskEvent event, Emitter<TodosState> emit) async {
    final ToDoDetailEntity detail = ToDoDetailEntity(
      toDoId: state.taskLoaded?.id,
      title: event.description,
      description: event.description,
      complete: false,
      orderDetail: state.taskDetailsLoaded.length + 1,
    );
    final createdResult = await TodosLocalService.provider.addNewDetailTask(
      detail,
    );

    if (createdResult > 0) {
      final details = List<ToDoDetailEntity>.from(state.taskDetailsLoaded);
      details.add(detail.copyWith(id: createdResult));

      emit(state.copyWith(taskDetailsLoaded: details));

      await TodosLocalService.provider.updateTodo(
        state.taskLoaded!.copyWith(
          totalItems: state.taskDetailsLoaded.length,
          percentCompleted: checkPercentCompeted(),
        ),
      );
    }
  }

  reorderDetail(TodoReorderDetailEvent event, Emitter<TodosState> emit) async {
    int newIndex = event.newIndex;
    int oldIndex = event.oldIndex;

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final details = List<ToDoDetailEntity>.from(state.taskDetailsLoaded);
    final element = details.removeAt(oldIndex);
    details.insert(newIndex, element);

    final detallesActualizados = List<ToDoDetailEntity>.generate(
      details.length,
      (index) => details[index].copyWith(orderDetail: index + 1),
    );

    emit(state.copyWith(taskDetailsLoaded: details));

    await TodosLocalService.provider.updateOrderDetails(
      detallesActualizados,
    );
  }

  deleteDetail(TodoDeleteDetailEvent event, Emitter<TodosState> emit) async {
    final details = List<ToDoDetailEntity>.from(state.taskDetailsLoaded);

    details.removeAt(event.index);

    emit(state.copyWith(taskDetailsLoaded: details));
  }

  markCheckTask(
    TodoMarkCheckDetailEvent event,
    Emitter<TodosState> emit,
  ) async {
    final details = List<ToDoDetailEntity>.from(state.taskDetailsLoaded);
    ToDoDetailEntity element = details[event.index];
    final newElement = element.copyWith(
      complete: element.complete,
    );
    await TodosLocalService.provider.updateDetailTask(newElement);
    details[event.index] = newElement;
    emit(state.copyWith(taskDetailsLoaded: details));

    await TodosLocalService.provider.updateTodo(
      state.taskLoaded!.copyWith(
        totalItems: state.taskDetailsLoaded.length,
        percentCompleted: checkPercentCompeted(),
      ),
    );
  }

  editDetail(TodoEditDetailEvent event, Emitter<TodosState> emit) async {
    final details = List<ToDoDetailEntity>.from(state.taskDetailsLoaded);
    ToDoDetailEntity element = details[event.index];
    element = element.copyWith(description: event.description);
    final updateResult = await TodosLocalService.provider.updateDetailTask(
      element,
    );
    if (updateResult > 0) {
      details[event.index] = element;
      emit(state.copyWith(taskDetailsLoaded: details));
    }
  }

  bool checkCompleted() {
    return state.taskDetailsLoaded.every(
      (element) => element.complete,
    );
  }

  checkPercentCompeted() {
    final itemsCompletados = List<ToDoDetailEntity>.from(
      state.taskDetailsLoaded,
    ).where((e) => e.complete);

    return state.taskDetailsLoaded.isNotEmpty
        ? (itemsCompletados.length * 100 / state.taskDetailsLoaded.length)
            .round()
        : 0;
  }
}
