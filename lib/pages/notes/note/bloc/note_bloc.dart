import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutterQuill;
import 'dart:convert';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';
import 'package:lubby_app/pages/notes/note/note_status_enum.dart';
import 'package:lubby_app/pages/notes/notes/bloc/notes_bloc.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesBloc? notesBloc;
  final NoteModel? note;

  NoteBloc(this.notesBloc, this.note)
      : super(
          NoteState(
            editing: note != null,
            note: note,
            titleController: TextEditingController(text: note?.title ?? ''),
            focusNodeNote: FocusNode(),
            flutterQuillcontroller: note == null
                ? flutterQuill.QuillController.basic()
                : flutterQuill.QuillController(
                    document: flutterQuill.Document.fromJson(
                      jsonDecode(note.body),
                    ),
                    selection: const TextSelection.collapsed(offset: 0),
                  ),
            favorite: note?.favorite == 1,
          ),
        ) {
    on<NoteCreatedEvent>(this.createNote);

    on<NoteUpdatedEvent>(this.updateNote);

    on<NoteMarkFavoriteEvent>(this.markFavoriteNote);

    on<NoteDeletedEvent>(this.deleteNote);
  }

  createNote(NoteCreatedEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(loading: true));
    final NoteModel note = NoteModel(
      title: state.titleController.text,
      body: jsonEncode(
        state.flutterQuillcontroller.document.toDelta().toJson(),
      ),
      createdAt: DateTime.now(),
      favorite: state.favorite ? 1 : 0,
      color: 1,
    );
    await DatabaseProvider.db.addNewNote(note);
    emit(state.copyWith(
      loading: false,
      status: NoteStatusEnum.created,
    ));
  }

  updateNote(NoteUpdatedEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(loading: true));
    final NoteModel note = state.note!.copyWith(
      title: state.titleController.text,
      body: jsonEncode(
        state.flutterQuillcontroller.document.toDelta().toJson(),
      ),
      favorite: state.favorite ? 1 : 0,
      color: 1,
    );
    await DatabaseProvider.db.updateNote(note);
    this.notesBloc!.add(NotesGetEvent());
    emit(state.copyWith(note: note, loading: false));
  }

  deleteNote(NoteDeletedEvent event, Emitter<NoteState> emit) async {
    final deleteresult = await DatabaseProvider.db.deleteNote(
      state.note!.id!,
    );
    if (deleteresult > 0) {
      emit(state.copyWith(status: NoteStatusEnum.deleted));
      return;
    }

    emit(state.copyWith(status: NoteStatusEnum.error));
  }

  markFavoriteNote(NoteMarkFavoriteEvent event, Emitter<NoteState> emit) {
    emit(state.copyWith(
      favorite: !state.favorite,
    ));
  }
}
