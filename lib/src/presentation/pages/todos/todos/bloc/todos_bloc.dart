import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:lubby_app/src/data/models/todo_model.dart';

import '../../../../../data/datasources/local/services/todos_local_service.dart';
import '../../type_filter_enum.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc()
      : super(TodosState(
          todos: const [],
          searchInputController: TextEditingController(),
        )) {
    on<TodosLoadDataEvent>(getTodos);

    on<TodosShowFabEvent>(showHideFab);
  }

  getTodos(TodosLoadDataEvent event, Emitter<TodosState> emit) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(seconds: 2));

    final todos = await TodosLocalService.provider.getTasks(
      type: TypeFilterEnum.enProceso,
    );

    emit(state.copyWith(
      todos: todos,
      loading: false,
    ));
  }

  showHideFab(TodosShowFabEvent event, Emitter<TodosState> emit) {
    emit(state.copyWith(showFab: event.showFab));
  }

  @override
  Future<void> close() {
    state.searchInputController.dispose();
    return super.close();
  }
}
