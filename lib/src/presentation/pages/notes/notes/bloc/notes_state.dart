part of 'notes_bloc.dart';

class NotesState extends Equatable {
  final List<NoteModel> notes;
  final bool showFab;
  final bool loading;
  final TextEditingController searchInputController;

  const NotesState({
    required this.notes,
    required this.searchInputController,
    this.showFab = true,
    this.loading = false,
  });

  NotesState copyWith({
    bool? showFab,
    bool? loading,
    List<NoteModel>? notes,
  }) =>
      NotesState(
        notes: notes ?? this.notes,
        showFab: showFab ?? this.showFab,
        loading: loading ?? this.loading,
        searchInputController: searchInputController,
      );

  @override
  List<Object?> get props => [
        notes,
        showFab,
        loading,
        searchInputController,
      ];
}
