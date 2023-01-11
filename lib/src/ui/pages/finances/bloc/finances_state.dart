part of 'finances_bloc.dart';

class FinancesState extends Equatable {
  final List<LabelEntity> labels;

  const FinancesState({
    this.labels = const [],
  });

  FinancesState copyWith({
    List<LabelEntity>? labels,
  }) =>
      FinancesState(
        labels: labels ?? this.labels,
      );

  @override
  List<Object> get props => [
        labels,
      ];
}
