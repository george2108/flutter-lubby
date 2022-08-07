part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final ToDoModel? toDo;
  final List<ToDoDetailModel> toDoDetails;

  final bool loading;
  final bool editing;
  final GlobalKey<FormState> formKey;
  final TextEditingController toDoTitleController;
  final TextEditingController toDoDescriptionController;
  final StatusCrudEnum status;

  TodoState({
    required this.editing,
    required this.formKey,
    required this.toDoTitleController,
    required this.toDoDescriptionController,
    this.loading = false,
    this.toDo,
    this.toDoDetails = const [],
    this.status = StatusCrudEnum.none,
  });

  TodoState copyWith({
    List<ToDoDetailModel>? toDoDetails,
    bool? loading,
    StatusCrudEnum? status,
  }) =>
      TodoState(
        toDo: this.toDo,
        toDoDetails: toDoDetails ?? this.toDoDetails,
        loading: loading ?? this.loading,
        editing: this.editing,
        formKey: this.formKey,
        toDoTitleController: this.toDoTitleController,
        toDoDescriptionController: this.toDoDescriptionController,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        toDo,
        toDoDetails,
        loading,
        editing,
        formKey,
        toDoTitleController,
        toDoDescriptionController,
        status,
      ];
}
