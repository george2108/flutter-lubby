part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class NotesGetEvent extends NotesEvent {
  @override
  List<Object?> get props => [];
}

class NotesShowHideFabEvent extends NotesEvent {
  final bool showFab;

  const NotesShowHideFabEvent(this.showFab);

  @override
  List<Object?> get props => [showFab];
}
