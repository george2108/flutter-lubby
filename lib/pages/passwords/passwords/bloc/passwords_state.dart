part of 'passwords_bloc.dart';

class PasswordsState extends Equatable {
  final List<PasswordModel> passwords;
  final bool showFab;
  final bool loading;
  final TextEditingController searchInputController;

  final PassDeletedEventEnum passEvent;

  PasswordsState({
    required this.passwords,
    required this.searchInputController,
    this.passEvent = PassDeletedEventEnum.none,
    this.showFab = true,
    this.loading = false,
  });

  PasswordsState copyWith({
    List<PasswordModel>? passwords,
    bool? showFab,
    bool? loading,
    PassDeletedEventEnum? passEvent,
  }) =>
      PasswordsState(
        passwords: passwords ?? this.passwords,
        showFab: showFab ?? this.showFab,
        loading: loading ?? this.loading,
        searchInputController: this.searchInputController,
        passEvent: passEvent ?? this.passEvent,
      );

  @override
  List<Object?> get props => [
        passwords,
        showFab,
        loading,
        searchInputController,
        passEvent,
      ];
}
