part of 'note_bloc.dart';

abstract class NoteState extends Equatable {}

class NoteInitialState extends NoteState {
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
  final bool loading;

  NoteLoadedState({
    required this.editing,
    required this.titleController,
    required this.flutterQuillcontroller,
    required this.focusNodeNote,
    required this.favorite,
    this.loading = false,
    this.note,
  });

  NoteLoadedState copyWith({
    bool? favorite,
    NoteModel? note,
    bool? loading,
  }) {
    return NoteLoadedState(
      editing: this.editing,
      titleController: this.titleController,
      flutterQuillcontroller: this.flutterQuillcontroller,
      focusNodeNote: this.focusNodeNote,
      favorite: favorite ?? this.favorite,
      note: note ?? this.note,
      loading: loading ?? this.loading,
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
      ];
}

class NoteCreatedState extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteUpdatedState extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteDeletedState extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteErrorState extends NoteState {
  final String error;
  final String content;

  NoteErrorState(this.error, this.content);

  @override
  List<Object?> get props => [error, content];
}
