part of 'finances_bloc.dart';

abstract class FinancesEvent extends Equatable {}

class ChangePageEvent extends FinancesEvent {
  final int index;

  ChangePageEvent(this.index);

  @override
  List<Object?> get props => [index];
}
