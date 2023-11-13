part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRegisterEvent extends AuthEvent {
  final RegisterRequestDTO data;

  const AuthRegisterEvent({required this.data});

  @override
  List<Object> get props => [data];
}
