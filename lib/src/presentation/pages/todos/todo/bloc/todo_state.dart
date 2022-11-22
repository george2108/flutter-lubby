part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final ToDoModel toDo;
  final List<ToDoDetailModel> toDoDetails;
  final Color color;
  final bool favorite;

  final bool loading;
  final GlobalKey<FormState> formKey;
  final TextEditingController toDoTitleController;
  final TextEditingController toDoDescriptionController;
  final StatusCrudEnum status;

  const TodoState({
    required this.formKey,
    required this.toDoTitleController,
    required this.toDoDescriptionController,
    required this.color,
    required this.favorite,
    required this.toDo,
    this.loading = false,
    this.toDoDetails = const [],
    this.status = StatusCrudEnum.none,
  });

  TodoState copyWith({
    List<ToDoDetailModel>? toDoDetails,
    bool? loading,
    StatusCrudEnum? status,
    Color? color,
    bool? favorite,
  }) =>
      TodoState(
        toDo: toDo,
        toDoDetails: toDoDetails ?? this.toDoDetails,
        loading: loading ?? this.loading,
        formKey: formKey,
        toDoTitleController: toDoTitleController,
        toDoDescriptionController: toDoDescriptionController,
        status: status ?? this.status,
        color: color ?? this.color,
        favorite: favorite ?? this.favorite,
      );

  @override
  List<Object?> get props => [
        toDo,
        toDoDetails,
        loading,
        formKey,
        toDoTitleController,
        toDoDescriptionController,
        status,
        color,
        favorite,
      ];
}
