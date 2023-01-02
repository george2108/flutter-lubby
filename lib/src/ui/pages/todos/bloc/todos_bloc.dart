import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lubby_app/src/data/entities/todo_entity.dart';

import '../../../../data/datasources/local/services/todos_local_service.dart';
import '../enum/type_filter_enum.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc()
      : super(TodosState(
          todosLists: const [],
          tasks: const [],
          dateTasks: DateTime.now(),
        )) {
    on<GetTodosListsEvent>(getTodosLists);
    on<GetTasksEvent>(getTasks);
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
}
