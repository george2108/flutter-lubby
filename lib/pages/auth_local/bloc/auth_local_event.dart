part of 'auth_local_bloc.dart';

@immutable
abstract class AuthLocalEvent {}

class CheckAuthenticatedEvent extends AuthLocalEvent {}
