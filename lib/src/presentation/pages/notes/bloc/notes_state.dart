part of 'notes_bloc.dart';

class NotesState extends Equatable {
  final List<NoteEntity> notes;
  final bool loading;
  final TextEditingController searchInputController;

  const NotesState({
    required this.notes,
    required this.searchInputController,
    this.loading = false,
  });

  NotesState copyWith({
    bool? loading,
    List<NoteEntity>? notes,
  }) =>
      NotesState(
        notes: notes ?? this.notes,
        loading: loading ?? this.loading,
        searchInputController: searchInputController,
      );

  @override
  List<Object?> get props => [
        notes,
        loading,
        searchInputController,
      ];
}
