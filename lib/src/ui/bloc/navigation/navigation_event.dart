part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class ChangeNavigationEvent extends NavigationEvent {
  final String item;

  const ChangeNavigationEvent({required this.item});

  @override
  List<Object> get props => [item];
}
