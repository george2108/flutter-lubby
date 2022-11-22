import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/core/enums/status_crud_enum.dart';
import 'package:lubby_app/db/todos_database_provider.dart';
import 'package:lubby_app/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ToDoModel toDo;

  TodoBloc(this.toDo)
      : super(
          TodoState(
            formKey: GlobalKey<FormState>(),
            toDo: toDo,
            toDoTitleController: TextEditingController(
              text: toDo.title,
            ),
            toDoDescriptionController: TextEditingController(
              text: toDo.description,
            ),
            color: toDo.color,
            favorite: toDo.favorite == 1,
          ),
        ) {
    on<TodoAddTaskEvent>(addTask);

    on<TodoReorderDetailEvent>(reorderDetail);

    on<TodoMarkCheckDetailEvent>(markCheckTask);

    on<TodoDeleteDetailEvent>(deleteDetail);

    on<TodoEditDetailEvent>(editDetail);

    on<TodoGetDetailsByTodoIdEvent>(getDetails);

    on<TodoChangeColorEvent>(changeColor);

    on<TodoMarkFavoriteEvent>(markTodoFavorite);
  }

  getDetails(
    TodoGetDetailsByTodoIdEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final data =
        await TodosDatabaseProvider.provider.getTaskDetail(event.todoId);
    emit(state.copyWith(toDoDetails: data, loading: false));
  }

  addTask(TodoAddTaskEvent event, Emitter<TodoState> emit) async {
    final ToDoDetailModel detail = ToDoDetailModel(
      toDoId: state.toDo.id,
      description: event.description,
      complete: 0,
      orderDetail: state.toDoDetails.length + 1,
    );
    final createdResult = await TodosDatabaseProvider.provider.addNewDetailTask(
      detail,
    );

    if (createdResult > 0) {
      final details = List<ToDoDetailModel>.from(state.toDoDetails);
      details.add(detail.copyWith(id: createdResult));

      emit(state.copyWith(toDoDetails: details));

      await TodosDatabaseProvider.provider.updateTodo(
        state.toDo.copyWith(
          totalItems: state.toDoDetails.length,
          percentCompleted: checkPercentCompeted(),
        ),
      );
    }
  }

  reorderDetail(TodoReorderDetailEvent event, Emitter<TodoState> emit) async {
    int newIndex = event.newIndex;
    int oldIndex = event.oldIndex;

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final details = List<ToDoDetailModel>.from(state.toDoDetails);
    final element = details.removeAt(oldIndex);
    details.insert(newIndex, element);

    final detallesActualizados = List<ToDoDetailModel>.generate(
      details.length,
      (index) => details[index].copyWith(orderDetail: index + 1),
    );

    emit(state.copyWith(toDoDetails: details));

    await TodosDatabaseProvider.provider.updateOrderDetails(
      detallesActualizados,
    );
  }

  deleteDetail(TodoDeleteDetailEvent event, Emitter<TodoState> emit) async {
    final details = List<ToDoDetailModel>.from(state.toDoDetails);

    details.removeAt(event.index);

    emit(state.copyWith(toDoDetails: details));
  }

  markCheckTask(
    TodoMarkCheckDetailEvent event,
    Emitter<TodoState> emit,
  ) async {
    final details = List<ToDoDetailModel>.from(state.toDoDetails);
    ToDoDetailModel element = details[event.index];
    final newElement = element.copyWith(
      complete: element.complete == 1 ? 0 : 1,
    );
    await TodosDatabaseProvider.provider.updateDetailTask(newElement);
    details[event.index] = newElement;
    emit(state.copyWith(toDoDetails: details));

    await TodosDatabaseProvider.provider.updateTodo(
      state.toDo.copyWith(
        totalItems: state.toDoDetails.length,
        percentCompleted: checkPercentCompeted(),
      ),
    );
  }

  editDetail(TodoEditDetailEvent event, Emitter<TodoState> emit) async {
    final details = List<ToDoDetailModel>.from(state.toDoDetails);
    ToDoDetailModel element = details[event.index];
    element = element.copyWith(description: event.description);
    final updateResult = await TodosDatabaseProvider.provider.updateDetailTask(
      element,
    );
    if (updateResult > 0) {
      details[event.index] = element;
      emit(state.copyWith(toDoDetails: details));
    }
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

    return state.toDoDetails.isNotEmpty
        ? (itemsCompletados.length * 100 / state.toDoDetails.length).round()
        : 0;
  }

  changeColor(
    TodoChangeColorEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  markTodoFavorite(
    TodoMarkFavoriteEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(favorite: !state.favorite));
  }

  @override
  Future<void> close() async {
    state.toDoDescriptionController.dispose();
    state.toDoTitleController.dispose();
    return super.close();
  }
}
