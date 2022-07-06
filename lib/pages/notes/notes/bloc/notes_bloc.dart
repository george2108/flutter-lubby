import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitialState()) {
    on<NotesGetEvent>(this.getNotes);
  }

  Future<void> getNotes(
    NotesGetEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState(true));
    final List<NoteModel> notes = await DatabaseProvider.db.getAllNotes();
    emit(NotesLoadingState(false));
    emit(NotesLoadedState(notes));
  }
}
