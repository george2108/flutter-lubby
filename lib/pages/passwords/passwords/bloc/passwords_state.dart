part of 'passwords_bloc.dart';

abstract class PasswordsState extends Equatable {
  final List<PasswordModel>? passwords;
  final bool? loading;
  final bool? showPassword;

  PasswordsState({
    this.passwords,
    this.loading,
    this.showPassword,
  });
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
