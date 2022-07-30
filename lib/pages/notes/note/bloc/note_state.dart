part of 'note_bloc.dart';

class NoteState extends Equatable {
  final NoteModel? note;

  final TextEditingController titleController;
  final flutterQuill.QuillController flutterQuillcontroller;
  final bool favorite;

  final FocusNode focusNodeNote;
  final StatusCrudEnum status;
  final bool editing;
  final bool loading;

  NoteState({
    required this.editing,
    required this.titleController,
    required this.flutterQuillcontroller,
    required this.focusNodeNote,
    required this.favorite,
    this.loading = false,
    this.status = StatusCrudEnum.none,
    this.note,
  });

  NoteState copyWith({
    bool? favorite,
    NoteModel? note,
    bool? loading,
    StatusCrudEnum? status,
  }) {
    return NoteState(
      editing: this.editing,
      titleController: this.titleController,
      flutterQuillcontroller: this.flutterQuillcontroller,
      focusNodeNote: this.focusNodeNote,
      favorite: favorite ?? this.favorite,
      note: note ?? this.note,
      loading: loading ?? this.loading,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        note,
        editing,
        titleController,
        flutterQuillcontroller,
        focusNodeNote,
        favorite,
        loading,
        status,
      ];
}
