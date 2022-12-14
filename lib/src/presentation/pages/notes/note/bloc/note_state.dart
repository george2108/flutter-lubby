part of 'note_bloc.dart';

class NoteState extends Equatable {
  final NoteEntity? note;

  final TextEditingController titleController;
  final flutter_quill.QuillController flutterQuillcontroller;
  final bool favorite;
  final Color color;
  final List<XFile> files;

  final FocusNode focusNodeNote;
  final StatusCrudEnum status;
  final bool editing;
  final bool loading;

  const NoteState({
    required this.editing,
    required this.titleController,
    required this.flutterQuillcontroller,
    required this.focusNodeNote,
    required this.favorite,
    required this.color,
    this.loading = false,
    this.status = StatusCrudEnum.none,
    this.note,
    this.files = const [],
  });

  NoteState copyWith({
    bool? favorite,
    NoteEntity? note,
    bool? loading,
    StatusCrudEnum? status,
    Color? color,
    List<XFile>? files,
  }) {
    return NoteState(
      editing: editing,
      titleController: titleController,
      flutterQuillcontroller: flutterQuillcontroller,
      focusNodeNote: focusNodeNote,
      favorite: favorite ?? this.favorite,
      note: note ?? this.note,
      loading: loading ?? this.loading,
      status: status ?? this.status,
      color: color ?? this.color,
      files: files ?? this.files,
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
        color,
        files,
      ];
}
