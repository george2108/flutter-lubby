part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

///
/// Agregar una tarea a la lista de tareas
///
class TodoAddTaskEvent extends TodoEvent {
  final String description;

  const TodoAddTaskEvent(this.description);

  @override
  List<Object?> get props => [];
}

///
/// Re ordenar las tareas
///
class TodoReorderDetailEvent extends TodoEvent {
  final int newIndex;
  final int oldIndex;

  const TodoReorderDetailEvent(this.newIndex, this.oldIndex);

  @override
  List<Object?> get props => [newIndex, oldIndex];
}

///
/// Marcar con check - falso o verdadero - una tarea
///
class TodoMarkCheckDetailEvent extends TodoEvent {
  final int index;

  const TodoMarkCheckDetailEvent(this.index);

  @override
  List<Object?> get props => [index];
}

///
/// ELiminar una tarea
///
class TodoDeleteDetailEvent extends TodoEvent {
  final int index;

  const TodoDeleteDetailEvent(this.index);

  @override
  List<Object?> get props => [index];
}

///
/// Editar una tarea, solo la descripcion
///
class TodoEditDetailEvent extends TodoEvent {
  final int index;
  final String description;

  const TodoEditDetailEvent(this.index, this.description);

  @override
  List<Object?> get props => [
        index,
        description,
      ];
}

///
/// Obtener los detalles de una lista de tareas con el id de la lista
///
class TodoGetDetailsByTodoIdEvent extends TodoEvent {
  final int todoId;

  const TodoGetDetailsByTodoIdEvent(this.todoId);

  @override
  List<Object?> get props => [todoId];
}

class TodoChangeColorEvent extends TodoEvent {
  final Color color;

  const TodoChangeColorEvent(this.color);

  @override
  List<Object?> get props => [color];
}

class TodoMarkFavoriteEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}
