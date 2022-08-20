part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

///
/// Guardar la lista de tareas
///
class TodoCreatedEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoUpdatedEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

///
/// Agregar una tarea a la lista de tareas
///
class TodoAddTaskEvent extends TodoEvent {
  final String description;

  TodoAddTaskEvent(this.description);

  @override
  List<Object?> get props => [];
}

///
/// Re ordenar las tareas
///
class TodoReorderDetailEvent extends TodoEvent {
  final int newIndex;
  final int oldIndex;

  TodoReorderDetailEvent(this.newIndex, this.oldIndex);

  @override
  List<Object?> get props => [newIndex, oldIndex];
}

///
/// Marcar con check - falso o verdadero - una tarea
///
class TodoMarkCheckDetailEvent extends TodoEvent {
  final int index;

  TodoMarkCheckDetailEvent(this.index);

  @override
  List<Object?> get props => [index];
}

///
/// ELiminar una tarea
///
class TodoDeleteDetailEvent extends TodoEvent {
  final int index;

  TodoDeleteDetailEvent(this.index);

  @override
  List<Object?> get props => [index];
}

///
/// Editar una tarea, solo la descripcion
///
class TodoEditDetailEvent extends TodoEvent {
  final int index;
  final String description;

  TodoEditDetailEvent(this.index, this.description);

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

  TodoGetDetailsByTodoIdEvent(this.todoId);

  @override
  List<Object?> get props => [todoId];
}

class TodoChangeColorEvent extends TodoEvent {
  final Color color;

  TodoChangeColorEvent(this.color);

  @override
  List<Object?> get props => [color];
}

class TodoMarkFavoriteEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}
