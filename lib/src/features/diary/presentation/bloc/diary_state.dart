part of 'diary_bloc.dart';

class DiaryState extends Equatable {
  final List<DiaryEntity> diariesOneDate;

  const DiaryState({
    this.diariesOneDate = const [],
  });

  DiaryState copyWith({
    List<DiaryEntity>? diariesOneDate,
  }) =>
      DiaryState(
        diariesOneDate: diariesOneDate ?? this.diariesOneDate,
      );

  @override
  List<Object> get props => [
        diariesOneDate,
      ];
}
