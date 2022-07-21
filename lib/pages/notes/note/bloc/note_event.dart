part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class NoteInitialEvent extends NoteEvent {
  final NoteModel? note;

  NoteInitialEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class NoteCreatedEvent extends NoteEvent {
  NoteCreatedEvent();
  @override
  List<Object?> get props => [];
}

class NoteUpdatedEvent extends NoteEvent {
  @override
  List<Object?> get props => [];
}

class NoteDeletedEvent extends NoteEvent {
  @override
  List<Object?> get props => [];
}

class NoteMarkFavoriteEvent extends NoteEvent {
  @override
  List<Object?> get props => [];
}
