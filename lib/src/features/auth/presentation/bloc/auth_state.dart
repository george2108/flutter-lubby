part of 'auth_bloc.dart';

abstract class AuthState implements Equatable {
  final bool authenticated;
  final UserEntity? user;

  const AuthState({
    this.authenticated = false,
    this.user,
  });

  @override
  List<Object?> get props => [authenticated, user];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class AuthLoading extends AuthState {
  const AuthLoading() : super();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class AuthSuccess extends AuthState {
  const AuthSuccess({
    required super.authenticated,
    super.user,
  });

  @override
  List<Object?> get props => [authenticated, user];

  @override
  bool? get stringify => true;
}

class AuthLogOut extends AuthState {
  const AuthLogOut({
    required super.authenticated,
    super.user,
  });

  @override
  List<Object?> get props => [authenticated, user];

  @override
  bool? get stringify => true;
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message}) : super();

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}
