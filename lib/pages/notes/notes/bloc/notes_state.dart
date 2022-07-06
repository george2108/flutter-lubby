part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitialState extends NotesState {
  @override
  List<Object?> get props => [];
}

class NotesLoadedState extends NotesState {
  final List<NoteModel> notes;

  NotesLoadedState(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NotesLoadingState extends NotesState {
  final bool loading;

  NotesLoadingState(this.loading);

  @override
  List<Object?> get props => [loading];
}
