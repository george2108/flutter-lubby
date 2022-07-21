import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutterQuill;
import 'dart:convert';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/notes/bloc/notes_bloc.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesBloc? notesBloc;

  NoteBloc(this.notesBloc) : super(NoteInitialState()) {
    on<NoteInitialEvent>(this.loadNoteInitial);

    on<NoteCreatedEvent>(this.createNote);

    on<NoteUpdatedEvent>(this.updateNote);

    on<NoteMarkFavoriteEvent>(this.markFavoriteNote);

    on<NoteDeletedEvent>(this.deleteNote);
  }

  loadNoteInitial(
    NoteInitialEvent event,
    Emitter<NoteState> emit,
  ) {
    emit(NoteLoadedState(
      editing: event.note != null,
      note: event.note,
      titleController: TextEditingController(text: event.note?.title ?? ''),
      focusNodeNote: FocusNode(),
      flutterQuillcontroller: event.note == null
          ? flutterQuill.QuillController.basic()
          : flutterQuill.QuillController(
              document:
                  flutterQuill.Document.fromJson(jsonDecode(event.note!.body)),
              selection: const TextSelection.collapsed(offset: 0),
            ),
      favorite: event.note?.favorite == 1,
    ));
  }

  createNote(NoteCreatedEvent event, Emitter<NoteState> emit) async {
    final currentState = state as NoteLoadedState;
    emit(NoteInitialState());
    emit(currentState.copyWith(loading: true));
    final NoteModel note = NoteModel(
      title: currentState.titleController.text,
      body: jsonEncode(
          currentState.flutterQuillcontroller.document.toDelta().toJson()),
      createdAt: DateTime.now(),
      favorite: currentState.favorite ? 1 : 0,
      color: 1,
    );
    await DatabaseProvider.db.addNewNote(note);
    emit(NoteInitialState());
    emit(currentState.copyWith(loading: false));
    emit(NoteCreatedState());
  }

  updateNote(NoteUpdatedEvent event, Emitter<NoteState> emit) async {
    final currentState = state as NoteLoadedState;
    emit(NoteInitialState());
    emit(currentState.copyWith(loading: true));
    final NoteModel note = currentState.note!.copyWith(
      title: currentState.titleController.text,
      body: jsonEncode(
        currentState.flutterQuillcontroller.document.toDelta().toJson(),
      ),
      favorite: currentState.favorite ? 1 : 0,
      color: 1,
    );
    await DatabaseProvider.db.updateNote(note);
    this.notesBloc!.add(NotesGetEvent());
    emit(NoteUpdatedState());
    emit(currentState.copyWith(note: note, loading: false));
  }

  deleteNote(NoteDeletedEvent event, Emitter<NoteState> emit) async {
    final currentState = state as NoteLoadedState;
    final deleteresult = await DatabaseProvider.db.deleteNote(
      currentState.note!.id!,
    );
    if (deleteresult > 0) {
      emit(NoteDeletedState());
      return;
    }
    emit(NoteErrorState(
      'Error al eliminar',
      'No se ha podido eliminar la nota, intente de nuevo',
    ));
    emit(currentState);
  }

  markFavoriteNote(NoteMarkFavoriteEvent event, Emitter<NoteState> emit) {
    final currentState = state as NoteLoadedState;
    emit(currentState.copyWith(
      favorite: !currentState.favorite,
    ));
  }
}
