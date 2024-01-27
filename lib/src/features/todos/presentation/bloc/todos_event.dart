part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class GetTodosListsEvent extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class GetTasksEvent extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class NavigateToDetailEvent extends TodosEvent {
  final BuildContext blocContext;
  final ToDoEntity todo;

  const NavigateToDetailEvent(
    this.blocContext,
    this.todo,
  );

  @override
  List<Object?> get props => [blocContext, todo];
}

////////////////////////////////////////////////////////////////////////////////
///
/// Agregar una tarea a la lista de tareas
///
////////////////////////////////////////////////////////////////////////////////
class TodoAddTaskEvent extends TodosEvent {
  final String description;

  const TodoAddTaskEvent(this.description);

  @override
  List<Object?> get props => [];
}

////////////////////////////////////////////////////////////////////////////////
///
/// Re ordenar las tareas
///
////////////////////////////////////////////////////////////////////////////////
class TodoReorderDetailEvent extends TodosEvent {
  final int newIndex;
  final int oldIndex;

  const TodoReorderDetailEvent(this.newIndex, this.oldIndex);

  @override
  List<Object?> get props => [newIndex, oldIndex];
}

////////////////////////////////////////////////////////////////////////////////
///
/// Marcar con check - falso o verdadero - una tarea
///
////////////////////////////////////////////////////////////////////////////////
class TodoMarkCheckDetailEvent extends TodosEvent {
  final int index;

  const TodoMarkCheckDetailEvent(this.index);

  @override
  List<Object?> get props => [index];
}

////////////////////////////////////////////////////////////////////////////////
///
/// ELiminar una tarea
///
////////////////////////////////////////////////////////////////////////////////
class TodoDeleteDetailEvent extends TodosEvent {
  final int index;

  const TodoDeleteDetailEvent(this.index);

  @override
  List<Object?> get props => [index];
}

////////////////////////////////////////////////////////////////////////////////
///
/// Editar una tarea, solo la descripcion
///
////////////////////////////////////////////////////////////////////////////////
class TodoEditDetailEvent extends TodosEvent {
  final int index;
  final String description;

  const TodoEditDetailEvent(this.index, this.description);

  @override
  List<Object?> get props => [
        index,
        description,
      ];
}

////////////////////////////////////////////////////////////////////////////////
///
/// Obtener los detalles de una lista de tareas con el id de la lista
///
////////////////////////////////////////////////////////////////////////////////
class TodoGetDetailsByTodoIdEvent extends TodosEvent {
  final int todoId;

  const TodoGetDetailsByTodoIdEvent(this.todoId);

  @override
  List<Object?> get props => [todoId];
}

class TodoChangeColorEvent extends TodosEvent {
  final Color color;

  const TodoChangeColorEvent(this.color);

  @override
  List<Object?> get props => [color];
}

class TodoMarkFavoriteEvent extends TodosEvent {
  @override
  List<Object?> get props => [];
}
