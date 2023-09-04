import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/domain/entities/note_entity.dart';
import 'package:lubby_app/src/data/repositories/label_repository.dart';
import 'package:lubby_app/src/data/repositories/note_repository.dart';

import '../../../../domain/entities/label_entity.dart';

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

    on<AddLabelEvent>(addLabel);
  }

  Future<void> getNotes(
    NotesGetEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(milliseconds: 500));
    final List<NoteEntity> notes = await _noteRepository.getAllNotes();

    for (var i = 0; i < notes.length; i++) {
      if (notes[i].labelId != null) {
        final label = await _labelRepository.getLabelById(notes[i].labelId!);
        notes[i] = notes[i].copyWith(label: label);
      }
    }

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
        await _labelRepository.getLabels([TypeLabels.notes]);

    emit(state.copyWith(
      labels: labels,
      loading: false,
    ));
  }

  Future<void> addLabel(
    AddLabelEvent event,
    Emitter<NotesState> emit,
  ) async {
    final labels = List<LabelEntity>.from(state.labels);
    labels.add(event.label);
    emit(state.copyWith(labels: labels));
  }

  createNote(NoteCreatedEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(loading: true));
    NoteEntity note = event.note;

    if (note.id == null) {
      final id = await _noteRepository.addNewNote(note);
      note = note.copyWith(id: id);
    }

    final List<NoteEntity> notesCopy = List.from(state.notes);
    // agregar la nota creada al principio si esta es favorita, si no agregarla al principio despues de las favoritas
    if (note.favorite) {
      notesCopy.insert(0, note);
    } else {
      final index = notesCopy.indexWhere((element) => element.favorite);
      if (index == -1) {
        notesCopy.add(note);
      } else {
        notesCopy.insert(index + 1, note);
      }
    }

    emit(state.copyWith(
      loading: false,
      notes: notesCopy,
    ));
  }

  updateNote(NoteUpdatedEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(loading: true));
    final NoteEntity note = event.note;
    await _noteRepository.updateNote(note);

    final List<NoteEntity> notes = List.from(state.notes);
    final index = notes.indexWhere((element) => element.id == note.id);
    notes[index] = note;

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
