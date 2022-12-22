import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/data/entities/note_entity.dart';

import '../../../../data/datasources/local/services/notes_local_service.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc()
      : super(
          NotesState(
            notes: const [],
            searchInputController: TextEditingController(),
          ),
        ) {
    on<NotesGetEvent>(getNotes);

    on<NoteCreatedEvent>(createNote);

    on<NoteUpdatedEvent>(updateNote);

    on<NoteDeletedEvent>(deleteNote);
  }

  Future<void> getNotes(
    NotesGetEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(milliseconds: 500));
    final List<NoteEntity> notes =
        await NotesLocalService.provider.getAllNotes();

    emit(state.copyWith(
      notes: notes,
      loading: false,
    ));
  }

  getNotesArray() {
    return state.notes;
  }

  createNote(NoteCreatedEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(loading: true));
    final NoteEntity note = event.note;
    await NotesLocalService.provider.addNewNote(note);
    emit(state.copyWith(
      loading: false,
      // status: StatusCrudEnum.created,
    ));
  }

  updateNote(NoteUpdatedEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(loading: true));
    final NoteEntity note = event.note;
    await NotesLocalService.provider.updateNote(note);

    final List<NoteEntity> notes =
        await NotesLocalService.provider.getAllNotes();

    emit(state.copyWith(
      notes: notes,
      loading: false,
    ));
    /* notesBloc.add(NotesGetEvent());
    emit(state.copyWith(
      note: note,
      loading: false,
      status: StatusCrudEnum.updated,
    ));
    emit(state.copyWith(status: StatusCrudEnum.none)); */
  }

  deleteNote(NoteDeletedEvent event, Emitter<NotesState> emit) async {
    final deleteresult = await NotesLocalService.provider.deleteNote(
      event.id,
    );
    if (deleteresult > 0) {
      // emit(state.copyWith(status: StatusCrudEnum.deleted));
      return;
    }
    // emit(state.copyWith(status: StatusCrudEnum.error));
  }
}
