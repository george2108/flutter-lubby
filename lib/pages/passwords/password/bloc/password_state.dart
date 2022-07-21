part of 'password_bloc.dart';

@immutable
abstract class PasswordState extends Equatable {}

class PasswordInitialState extends PasswordState {
  @override
  List<Object?> get props => [];
}

class PasswordLoadedState extends PasswordState {
  final PasswordModel? password;
  final bool editing;

  PasswordLoadedState(
    this.editing,
    this.password,
  );

  @override
  List<Object?> get props => [password, editing];
}
