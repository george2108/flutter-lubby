part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class NotesGetEvent extends NotesEvent {
  @override
  List<Object?> get props => [];
}
