part of 'diary_bloc.dart';

class DiaryState extends Equatable {
  final int index;

  const DiaryState({
    this.index = 0,
  });

  DiaryState copyWith({
    int? index,
  }) =>
      DiaryState(
        index: index ?? this.index,
      );

  @override
  List<Object> get props => [
        index,
      ];
}
