import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/todo_model.dart';
import 'package:lubby_app/pages/todos/type_filter_enum.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitialState()) {
    on<TodosLoadDataEvent>(this.getTodos);
  }

  getTodos(TodosLoadDataEvent event, Emitter<TodosState> emit) async {
    emit(TodosLoadingState());

    final todos = await DatabaseProvider.db.getTasks(
      type: TypeFilterEnum.enProceso,
    );

    emit(TodosLoadedState(todos));
  }
}
