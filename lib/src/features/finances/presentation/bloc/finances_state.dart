part of 'finances_bloc.dart';

class FinancesState extends Equatable {
  final List<AccountEntity> accounts;
  final List<LabelEntity> categories;
  final List<TransactionEntity> transactions;

  const FinancesState({
    this.categories = const [],
    this.accounts = const [],
    this.transactions = const [],
  });

  FinancesState copyWith({
    List<LabelEntity>? categories,
    List<AccountEntity>? accounts,
    List<TransactionEntity>? transactions,
  }) =>
      FinancesState(
        categories: categories ?? this.categories,
        accounts: accounts ?? this.accounts,
        transactions: transactions ?? this.transactions,
      );

  @override
  List<Object> get props => [
        categories,
        accounts,
        transactions,
      ];
}
