part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class NoteCreatedEvent extends NoteEvent {
  const NoteCreatedEvent();

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

class NoteChangeColor extends NoteEvent {
  final Color color;

  const NoteChangeColor(this.color);

  @override
  List<Object?> get props => [color];
}
