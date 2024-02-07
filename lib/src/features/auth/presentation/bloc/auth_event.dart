part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEvent extends AuthEvent {
  const AuthCheckEvent();

  @override
  List<Object> get props => [];
}

class AuthRegisterEvent extends AuthEvent {
  final RegisterRequestDTO data;

  const AuthRegisterEvent({required this.data});

  @override
  List<Object> get props => [data];
}

class AuthLoginEvent extends AuthEvent {
  final LoginRequestDTO data;

  const AuthLoginEvent({required this.data});

  @override
  List<Object> get props => [data];
}

class AuthLogOutEvent extends AuthEvent {
  const AuthLogOutEvent();

  @override
  List<Object> get props => [];
}
