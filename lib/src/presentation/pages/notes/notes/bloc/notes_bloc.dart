import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/db/notes_database_provider.dart';
import 'package:lubby_app/src/data/models/note_model.dart';

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

    on<NotesShowHideFabEvent>(showHideFab);
  }

  Future<void> getNotes(
    NotesGetEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(milliseconds: 500));
    final List<NoteModel> notes =
        await NotesDatabaseProvider.provider.getAllNotes();

    emit(state.copyWith(
      notes: notes,
      loading: false,
    ));
  }

  showHideFab(NotesShowHideFabEvent event, Emitter<NotesState> emit) {
    emit(state.copyWith(showFab: event.showFab));
  }
}
