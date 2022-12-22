part of 'finances_bloc.dart';

class FinancesState extends Equatable {
  final int index;

  const FinancesState({
    this.index = 0,
  });

  FinancesState copyWith({
    int? index,
  }) =>
      FinancesState(
        index: index ?? this.index,
      );

  @override
  List<Object> get props => [index];
}
