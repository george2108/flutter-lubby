part of 'auth_local_bloc.dart';

@immutable
abstract class AuthLocalState {
  final bool authenticated;

  AuthLocalState(this.authenticated);
}

class AuthLocalInitialState extends AuthLocalState {
  final bool authenticated;
  AuthLocalInitialState(this.authenticated) : super(authenticated);
}
