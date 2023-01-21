part of 'notes_bloc.dart';

class NotesState extends Equatable {
  final List<NoteEntity> notes;
  final List<LabelEntity> labels;
  final bool loading;
  final TextEditingController searchInputController;

  const NotesState({
    required this.searchInputController,
    this.notes = const [],
    this.labels = const [],
    this.loading = false,
  });

  NotesState copyWith({
    bool? loading,
    List<NoteEntity>? notes,
    List<LabelEntity>? labels,
  }) =>
      NotesState(
        notes: notes ?? this.notes,
        loading: loading ?? this.loading,
        searchInputController: searchInputController,
        labels: labels ?? this.labels,
      );

  @override
  List<Object?> get props => [
        notes,
        loading,
        searchInputController,
        labels,
      ];
}
