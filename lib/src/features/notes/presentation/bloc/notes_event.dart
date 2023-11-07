part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class NotesGetEvent extends NotesEvent {
  @override
  List<Object?> get props => [];
}

class NoteCreatedEvent extends NotesEvent {
  final NoteEntity note;

  const NoteCreatedEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class NoteUpdatedEvent extends NotesEvent {
  final NoteEntity note;

  const NoteUpdatedEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class NoteDeletedEvent extends NotesEvent {
  final int id;

  const NoteDeletedEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddLabelEvent extends NotesEvent {
  final LabelEntity label;

  const AddLabelEvent(this.label);

  @override
  List<Object?> get props => [label];
}

class GetLabelsEvent extends NotesEvent {
  @override
  List<Object?> get props => [];
}
