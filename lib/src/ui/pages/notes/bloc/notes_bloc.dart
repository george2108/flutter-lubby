import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/data/entities/note_entity.dart';
import 'package:lubby_app/src/data/repositories/label_repository.dart';
import 'package:lubby_app/src/data/repositories/note_repository.dart';

import '../../../../data/entities/label_entity.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteRepository _noteRepository;
  final LabelRepository _labelRepository;

  NotesBloc(this._noteRepository, this._labelRepository)
      : super(
          NotesState(
            searchInputController: TextEditingController(),
          ),
        ) {
    on<NotesGetEvent>(getNotes);

    on<NoteCreatedEvent>(createNote);

    on<NoteUpdatedEvent>(updateNote);

    on<NoteDeletedEvent>(deleteNote);

    on<GetLabelsEvent>(getLabels);

    on<CreateLabelEvent>(createLabel);
  }

  Future<void> getNotes(
    NotesGetEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(milliseconds: 500));
    final List<NoteEntity> notes = await _noteRepository.getAllNotes();

    emit(state.copyWith(
      notes: notes,
      loading: false,
    ));
  }

  Future<void> getLabels(
    GetLabelsEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(milliseconds: 500));
    final List<LabelEntity> labels =
        await _labelRepository.getLabels(TypeLabels.notes);

    emit(state.copyWith(
      labels: labels,
      loading: false,
    ));
  }

  Future<void> createLabel(
    CreateLabelEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    final LabelEntity label = event.label;
    await _labelRepository.addNewLabel(label);

    final labels = List<LabelEntity>.from(state.labels);
    labels.add(label);

    emit(state.copyWith(
      labels: labels,
      loading: false,
    ));
  }

  getNotesArray() {
    return state.notes;
  }

  createNote(NoteCreatedEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(loading: true));
    final NoteEntity note = event.note;
    await _noteRepository.addNewNote(note);
    emit(state.copyWith(
      loading: false,
      // status: StatusCrudEnum.created,
    ));
  }

  updateNote(NoteUpdatedEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(loading: true));
    final NoteEntity note = event.note;
    await _noteRepository.updateNote(note);

    final List<NoteEntity> notes = await _noteRepository.getAllNotes();

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
    final deleteresult = await _noteRepository.deleteNote(
      event.id,
    );
    if (deleteresult > 0) {
      // emit(state.copyWith(status: StatusCrudEnum.deleted));
      return;
    }
    // emit(state.copyWith(status: StatusCrudEnum.error));
  }
}
