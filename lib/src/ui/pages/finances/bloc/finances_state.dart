part of 'finances_bloc.dart';

class FinancesState extends Equatable {
  final List<AccountEntity> accounts;
  final List<LabelEntity> categories;

  const FinancesState({
    this.categories = const [],
    this.accounts = const [],
  });

  FinancesState copyWith({
    List<LabelEntity>? categories,
    List<AccountEntity>? accounts,
  }) =>
      FinancesState(
        categories: categories ?? this.categories,
        accounts: accounts ?? this.accounts,
      );

  @override
  List<Object> get props => [
        categories,
        accounts,
      ];
}
