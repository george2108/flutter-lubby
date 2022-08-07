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
  PasswordsLoadedPasswordsState(this.passwords);

  @override
  List<Object?> get props => [passwords];
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
