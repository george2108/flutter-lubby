import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/core/enums/status_crud_enum.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ToDoModel? toDo;

  TodoBloc(this.toDo)
      : super(
          TodoState(
            editing: toDo != null,
            formKey: GlobalKey<FormState>(),
            toDo: toDo,
            toDoTitleController: TextEditingController(
              text: toDo == null ? '' : toDo.title,
            ),
            toDoDescriptionController: TextEditingController(
              text: toDo == null ? '' : toDo.description,
            ),
          ),
        ) {
    on<TodoCreatedEvent>(this.createTodo);

    on<TodoUpdatedEvent>(this.updateTodo);

    on<TodoAddTaskEvent>(this.addTask);

    on<TodoReorderDetailEvent>(this.reorderDetail);

    on<TodoMarkCheckDetailEvent>(this.markCheckTask);

    on<TodoDeleteDetailEvent>(this.deleteDetail);

    on<TodoEditDetailEvent>(this.editDetail);

    on<TodoGetDetailsByTodoIdEvent>(this.getDetails);
  }

  getDetails(
    TodoGetDetailsByTodoIdEvent event,
    Emitter<TodoState> emit,
  ) async {
    if (!state.editing) {
      return;
    }
    emit(state.copyWith(loading: true));
    final data = await DatabaseProvider.db.getTaskDetail(event.todoId);
    emit(state.copyWith(toDoDetails: data, loading: false));
  }

  updateTodo(TodoUpdatedEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(loading: true));

    final newTodo = state.toDo!.copyWith(
      title: state.toDoTitleController.text,
      description: state.toDoDescriptionController.text,
      complete: this.checkCompleted() ? 1 : 0,
      percentCompleted: this.checkPercentCompeted(),
    );
    // actualizar la lista de tareas que retorna los nuevos detalles
    final nuevosDetalles = await DatabaseProvider.db.updateTodo(
      newTodo,
      state.toDoDetails,
    );

    emit(state.copyWith(
      status: StatusCrudEnum.updated,
      loading: false,
      toDoDetails: nuevosDetalles,
    ));
  }

  createTodo(TodoCreatedEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(loading: true));

    final ToDoModel todoSave = ToDoModel(
      title: state.toDoTitleController.text,
      description: state.toDoDescriptionController.text,
      createdAt: DateTime.now(),
      complete: this.checkCompleted() ? 1 : 0,
      percentCompleted: this.checkPercentCompeted(),
    );
    final todoId = await DatabaseProvider.db.addNewToDo(todoSave);
    for (var i = 0; i < state.toDoDetails.length; i++) {
      final item = state.toDoDetails[i];
      await DatabaseProvider.db.addNewDetailTask(item.copyWith(
        todoId: todoId,
      ));
    }
    emit(state.copyWith(
      status: StatusCrudEnum.created,
      loading: false,
    ));
  }

  addTask(TodoAddTaskEvent event, Emitter<TodoState> emit) {
    final ToDoDetailModel detail = ToDoDetailModel(
      description: event.description,
      complete: 0,
      orderDetail: state.toDoDetails.length + 1,
    );
    final details = List<ToDoDetailModel>.from(state.toDoDetails);
    details.add(detail);
    emit(state.copyWith(toDoDetails: details));
  }

  reorderDetail(TodoReorderDetailEvent event, Emitter<TodoState> emit) {
    int newIndex = event.newIndex;
    int oldIndex = event.oldIndex;

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final details = List<ToDoDetailModel>.from(state.toDoDetails);
    final element = details.removeAt(oldIndex);
    details.insert(newIndex, element);
    emit(state.copyWith(toDoDetails: details));
  }

  deleteDetail(TodoDeleteDetailEvent event, Emitter<TodoState> emit) async {
    final details = List<ToDoDetailModel>.from(state.toDoDetails);
    final deleted = await DatabaseProvider.db.deleteDetail(
      details[event.index].id!,
    );
    print(deleted);
    if (deleted == 1) {
      details.removeAt(event.index);
      emit(state.copyWith(toDoDetails: details));
    }
  }

  markCheckTask(TodoMarkCheckDetailEvent event, Emitter<TodoState> emit) {
    final details = List<ToDoDetailModel>.from(state.toDoDetails);
    ToDoDetailModel element = details[event.index];
    element = element.copyWith(complete: element.complete == 1 ? 0 : 1);
    details[event.index] = element;
    emit(state.copyWith(toDoDetails: details));
  }

  editDetail(TodoEditDetailEvent event, Emitter<TodoState> emit) {
    final details = List<ToDoDetailModel>.from(state.toDoDetails);
    ToDoDetailModel element = details[event.index];
    element = element.copyWith(description: event.description);
    details[event.index] = element;
    emit(state.copyWith(toDoDetails: details));
  }

  bool checkCompleted() {
    return state.toDoDetails.every(
      (element) => element.complete == 1,
    );
  }

  checkPercentCompeted() {
    final itemsCompletados = List<ToDoDetailModel>.from(
      state.toDoDetails,
    ).where((e) => e.complete == 1);

    return state.toDoDetails.length > 0
        ? (itemsCompletados.length * 100 / state.toDoDetails.length).round()
        : 0;
  }

  @override
  Future<void> close() async {
    state.toDoDescriptionController.dispose();
    state.toDoTitleController.dispose();
    return super.close();
  }
}
