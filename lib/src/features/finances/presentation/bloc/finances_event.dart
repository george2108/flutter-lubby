part of 'finances_bloc.dart';

abstract class FinancesEvent extends Equatable {}

class AddLabelEvent extends FinancesEvent {
  final LabelEntity label;

  AddLabelEvent(this.label);

  @override
  List<Object?> get props => [label];
}

class GetCategoriesEvent extends FinancesEvent {
  GetCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class GetAccountsEvent extends FinancesEvent {
  GetAccountsEvent();

  @override
  List<Object?> get props => [];
}

class GetTransactionsEvent extends FinancesEvent {
  GetTransactionsEvent();

  @override
  List<Object?> get props => [];
}

class CreateAccountEvent extends FinancesEvent {
  final AccountEntity account;

  CreateAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}

class CreateTransactionEvent extends FinancesEvent {
  final TransactionEntity transaction;

  CreateTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
