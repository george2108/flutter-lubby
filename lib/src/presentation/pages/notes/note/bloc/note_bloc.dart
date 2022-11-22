import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:lubby_app/src/core/constants/constants.dart';
import 'package:lubby_app/src/core/enums/status_crud_enum.dart';
import 'dart:convert';

import 'package:lubby_app/db/notes_database_provider.dart';
import 'package:lubby_app/src/data/models/note_model.dart';

import '../../notes/bloc/notes_bloc.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesBloc notesBloc;
  final NoteModel? note;

  NoteBloc(this.notesBloc, this.note)
      : super(
          NoteState(
            editing: note != null,
            note: note,
            titleController: TextEditingController(text: note?.title ?? ''),
            focusNodeNote: FocusNode(),
            flutterQuillcontroller: note == null
                ? flutter_quill.QuillController.basic()
                : flutter_quill.QuillController(
                    document: flutter_quill.Document.fromJson(
                      jsonDecode(note.body),
                    ),
                    selection: const TextSelection.collapsed(offset: 0),
                  ),
            favorite: note?.favorite == 1,
            color: note?.color ?? kDefaultColorPick,
          ),
        ) {
    on<NoteCreatedEvent>(createNote);

    on<NoteUpdatedEvent>(updateNote);

    on<NoteMarkFavoriteEvent>(markFavoriteNote);

    on<NoteDeletedEvent>(deleteNote);

    on<NoteChangeColor>(changeColorNote);
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
      color: state.color,
    );
    await NotesDatabaseProvider.provider.addNewNote(note);
    emit(state.copyWith(
      loading: false,
      status: StatusCrudEnum.created,
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
      color: state.color,
    );
    await NotesDatabaseProvider.provider.updateNote(note);
    notesBloc.add(NotesGetEvent());
    emit(state.copyWith(
      note: note,
      loading: false,
      status: StatusCrudEnum.updated,
    ));
    emit(state.copyWith(status: StatusCrudEnum.none));
  }

  deleteNote(NoteDeletedEvent event, Emitter<NoteState> emit) async {
    final deleteresult = await NotesDatabaseProvider.provider.deleteNote(
      state.note!.id!,
    );
    if (deleteresult > 0) {
      emit(state.copyWith(status: StatusCrudEnum.deleted));
      return;
    }
    emit(state.copyWith(status: StatusCrudEnum.error));
  }

  markFavoriteNote(NoteMarkFavoriteEvent event, Emitter<NoteState> emit) {
    emit(state.copyWith(
      favorite: !state.favorite,
    ));
  }

  changeColorNote(NoteChangeColor event, Emitter<NoteState> emit) {
    emit(state.copyWith(color: event.color));
  }

  @override
  Future<void> close() async {
    state.flutterQuillcontroller.dispose();
    state.titleController.dispose();
    state.focusNodeNote.dispose();
    return super.close();
  }
}
