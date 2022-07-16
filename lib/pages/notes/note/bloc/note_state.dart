part of 'note_bloc.dart';

abstract class NoteState extends Equatable {}

class NoteInitialState extends NoteState {
  NoteInitialState();

  @override
  List<Object?> get props => [];
}

class NoteLoadedState extends NoteState {
  final bool editing;
  final TextEditingController titleController;
  final flutterQuill.QuillController flutterQuillcontroller;
  final NoteModel? note;
  final bool favorite;
  final FocusNode focusNodeNote;

  NoteLoadedState({
    required this.editing,
    required this.titleController,
    required this.flutterQuillcontroller,
    required this.focusNodeNote,
    required this.favorite,
    this.note,
  });

  NoteLoadedState copyWith({bool? favorite}) {
    return NoteLoadedState(
      editing: this.editing,
      titleController: this.titleController,
      flutterQuillcontroller: this.flutterQuillcontroller,
      focusNodeNote: this.focusNodeNote,
      favorite: favorite ?? this.favorite,
    );
  }

  @override
  List<Object?> get props => [
        note,
        editing,
        titleController,
        flutterQuillcontroller,
        focusNodeNote,
        favorite
      ];
}

class NoteCreatedState extends NoteState {
  @override
  List<Object?> get props => [];
}
