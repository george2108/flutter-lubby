part of 'finances_bloc.dart';

abstract class FinancesEvent extends Equatable {}

class SaveLabelEvent extends FinancesEvent {
  final LabelEntity label;

  SaveLabelEvent(this.label);

  @override
  List<Object?> get props => [label];
}

class GetLabelsEvent extends FinancesEvent {
  GetLabelsEvent();

  @override
  List<Object?> get props => [];
}

class GetAccountsEvent extends FinancesEvent {
  GetAccountsEvent();

  @override
  List<Object?> get props => [];
}

class CreateAccountEvent extends FinancesEvent {
  final AccountEntity account;

  CreateAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}
