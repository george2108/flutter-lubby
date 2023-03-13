part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {}

class SelectItemMenuEvent extends GlobalEvent {
  final int index;

  SelectItemMenuEvent(this.index);

  @override
  List<Object> get props => [index];
}
