part of 'passwords_bloc.dart';

class PasswordsState extends Equatable {
  final List<PasswordModel> passwords;
  final bool showFab;
  final bool loading;
  final TextEditingController searchInputController;

  final PasswordModel? lastPassDeleted;

  PasswordsState({
    required this.passwords,
    required this.searchInputController,
    this.lastPassDeleted = null,
    this.showFab = true,
    this.loading = false,
  });

  PasswordsState copyWith({
    List<PasswordModel>? passwords,
    bool? showFab,
    bool? loading,
    PasswordModel? lastPassDeleted,
  }) =>
      PasswordsState(
        passwords: passwords ?? this.passwords,
        showFab: showFab ?? this.showFab,
        loading: loading ?? this.loading,
        searchInputController: this.searchInputController,
        lastPassDeleted: lastPassDeleted ?? this.lastPassDeleted,
      );

  @override
  List<Object?> get props => [
        passwords,
        showFab,
        loading,
        searchInputController,
        lastPassDeleted,
      ];
}
