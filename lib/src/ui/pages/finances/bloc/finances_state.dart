part of 'finances_bloc.dart';

class FinancesState extends Equatable {
  final List<LabelEntity> labels;
  final List<AccountEntity> accounts;

  const FinancesState({
    this.labels = const [],
    this.accounts = const [],
  });

  FinancesState copyWith({
    List<LabelEntity>? labels,
    List<AccountEntity>? accounts,
  }) =>
      FinancesState(
        labels: labels ?? this.labels,
        accounts: accounts ?? this.accounts,
      );

  @override
  List<Object> get props => [
        labels,
        accounts,
      ];
}
