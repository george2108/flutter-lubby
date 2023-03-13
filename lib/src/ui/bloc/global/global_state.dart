part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final int currentIndexMenu;

  const GlobalState({
    this.currentIndexMenu = 0,
  });

  GlobalState copyWith({
    int? currentIndexMenu,
  }) =>
      GlobalState(
        currentIndexMenu: currentIndexMenu ?? this.currentIndexMenu,
      );

  @override
  List<Object> get props => [
        currentIndexMenu,
      ];
}
