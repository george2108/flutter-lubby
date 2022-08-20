part of 'passwords_bloc.dart';

abstract class PasswordsState extends Equatable {
  const PasswordsState();
}

class PasswordsInitialState extends PasswordsState {
  @override
  List<Object?> get props => [];
}

class PasswordsLoadedPasswordsState extends PasswordsState {
  final List<PasswordModel> passwords;
  final bool showFab;

  PasswordsLoadedPasswordsState(this.passwords, this.showFab);

  PasswordsLoadedPasswordsState copyWith({
    List<PasswordModel>? passwords,
    bool? showFab,
  }) =>
      PasswordsLoadedPasswordsState(
        passwords ?? this.passwords,
        showFab ?? this.showFab,
      );

  @override
  List<Object?> get props => [passwords, showFab];
}

class PasswordsLoadingState extends PasswordsState {
  final bool loading;

  PasswordsLoadingState(this.loading);

  @override
  List<Object?> get props => [loading];
}

class PasswordsDeletedState extends PasswordsState {
  @override
  List<Object?> get props => [];
}
