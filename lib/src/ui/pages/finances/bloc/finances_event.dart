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
