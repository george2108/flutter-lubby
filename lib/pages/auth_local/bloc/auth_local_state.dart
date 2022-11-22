part of 'auth_local_bloc.dart';

abstract class AuthLocalState {
  final bool authenticated;

  AuthLocalState(this.authenticated);
}

class AuthLocalInitialState extends AuthLocalState {
  AuthLocalInitialState(bool authenticated) : super(authenticated);
}
