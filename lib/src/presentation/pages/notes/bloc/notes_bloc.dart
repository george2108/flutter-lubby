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
}
